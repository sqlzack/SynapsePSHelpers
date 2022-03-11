# Synapse Pipeline Whitelist Script

## Pre-Requisites
- Azure Subscription ID
- Synapse Workspace Name
- Dev Endpoint URI for Synapse
- Pipeline Whitelist Text File (There are likely other ways)
- Powershell 7.2 and the Az Module Installed

## Included in this Folder
- **pipelineWhitelist.ps1** - This is the main PowerShell script. Please read comments in script before executing as there are parameters to be set.
- **pipelineWhitelist.txt** - This is an example of a pipelineWhitelist text file that could be used in conjunction with the ps1 to serve as a master list of allowed pipelines. 

## References
- [Synapse REST API - Delete Pipeline](https://docs.microsoft.com/en-us/rest/api/synapse/data-plane/pipeline/delete-pipeline)
- [Synapse REST API - Get Pipelines by Workspace](https://docs.microsoft.com/en-us/rest/api/synapse/data-plane/pipeline/get-pipelines-by-workspace)
- [Inspiration for Script](https://techcommunity.microsoft.com/t5/azure-synapse-analytics-blog/calling-synapse-rest-api-to-automate-tasks-using-powershell/ba-p/2202814)