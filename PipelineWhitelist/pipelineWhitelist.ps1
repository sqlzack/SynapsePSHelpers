######################## Parameters to set ########################
$workspaceName = "" #Enter your Synapse workspace here
$SubscriptionId = "" #Enter your Azure SubscriptionId Here
$uriBase = "" #Copy your synapse workspace Dev Endpoint here
$allowedPipelinesTxt = ".\PipelineWhitelist\pipelineWhitelist.txt"

######################## Uri parameters - may need set over time if new endpoints are available. ########################
#This endpoint is used to get the pipelines
$uriEndPoint = "pipelines?api-version=2020-12-01preview"
$uri = $uriBase+$uriEndPoint
$uri = "https://@{$workspaceName}.dev.azuresynapse.net/pipelines?api-version=2020-12-01preview"


######################## Connect to Azure ########################
#used to check if you're already connected to Azure.
$Context = Get-AzContext

#If you're not connected this connects to Azure.
if ($null -eq $Context) {
    Write-Information "Need to login"
    Connect-AzAccount -Subscription $SubscriptionId
}
else
{
    if ($Context.Subscription.Id -ne $SubscriptionId) {
        $result = Select-AzSubscription -Subscription $SubscriptionId
        Write-Host "Current subscription is $($result.Subscription.Name)"
    }
    else {
        Write-Host "Current subscription is $($Context.Subscription.Name)"    
    }
}

#Once connected, retreive an access token to use on Synapse REST endpoints.
$token = (Get-AzAccessToken -Resource "https://dev.azuresynapse.net").Token
$headers = @{
    Authorization = "Bearer $token"
    origin = "https://ms.web.azuresynapse.net"
    referer = "https://ms.web.azuresynapse.net"
}

######################## Retrieve Pipelines from Synapse ########################
$response = Invoke-RestMethod -Method Get -ContentType "application/json" -Uri $uri -Headers $headers
$pipelines = $response.value.Name

######################## Retrieve Whitelist from Text file ########################
$allowedPipelines = Get-Content -Path $allowedPipelinesTxt


######################## Determine pipelines that need deleted ########################
$pipelinesToDelete = @()

foreach($pipeline in $pipelines) {
   $isAllowedPipeline = "False"

   foreach($allowedPipeline in $allowedPipelines)
   {
       if($allowedPipeline -eq $pipeline)
       {
            $isAllowedPipeline ="True"
       }
   }

    #$isAllowedPipeline

    if($isAllowedPipeline -eq "False")
    {
        $pipelinesToDelete += $pipeline
    }
}

######################## Delete pipelines not in whitelist ########################
foreach($pipelineToDelete in $pipelinesToDelete)
{
    $deleteUri = "https://@{$workspaceName}.dev.azuresynapse.net/pipelines/${pipelineToDelete}?api-version=2020-12-01"
    Invoke-RestMethod -Method Delete -ContentType "application/json" -Uri $deleteUri -Headers $headers
}