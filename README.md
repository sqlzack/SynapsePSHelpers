# Synapse PowerShell Helpers

## Repo Overview
This is a small collection of PowerShell scripts that can be executed to perform small Synapse tasks. They are meant to be modified and are committed here to serve as examples of ways you could interact with the Synapse REST API and not necessarily how you should interact with it. Below are descriptions of the various scripts included in this repository.

### PipelineWhitelist 

This [script](./PipelineWhitelist) is going to be useful for optionally deploying pipelines in an environment. This could be handy in a multi-tenancy Synapse environment where you may have committed pipelines that you do not want to promote to QA/Prod Environments. This could also serve as an Azure DevOps or GitHub Actions deployment artifact so that you could remove all pipelines that are not intended to go to promoted environments after they have been published.


