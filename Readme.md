# azure-pipeline-yaml-preview
Script for compiling a azure pipeline yaml to its final yaml using the Azure Pipelines REST API.

# Instructions
Available parameters:
|    Parameter     | Alias |         Description         | Required |
| ---------------- | ----- | --------------------------- | -------- |
| -pipelineId      | -pid  | Pipeline ID                 | Required |
| -accessToken     | -pat  | Personal access token       | Required |
| -inputPath       | -i    | Input yaml path             | Required |
| -outputPath      | -o    | Output yaml path            | Optional |
| -organization    | -org  | DevOps organization         | Required |
| -project         | -p    | DevOps project              | Required |
| -outputToConsole | -oc   | Ouput final yaml to console | Optional |

# Todo:
Implement support for custom arguments & variables