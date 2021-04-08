param (
    [Parameter(Mandatory = $true)][Alias("pid")][string] $pipelineId,
    [Parameter(Mandatory = $true)][Alias("pat")][string] $accessToken,
    [Parameter(Mandatory = $true)][Alias("i")][string] $inputPath,
    [Parameter(Mandatory = $true)][Alias("o")][string] $outputPath = "./output.yml",
    [Parameter(Mandatory = $true)][Alias("org")][string] $organization,
    [Parameter(Mandatory = $false)][Alias("p")][string] $project,
    [Parameter(Mandatory = $false)][Alias("oc")][Switch] $outputToConsole = $false
)
$ymlFile = Get-Content -Path $inputPath | Out-String
$address = "https://dev.azure.com/$organization/$project/_apis/pipelines/$pipelineId/preview?api-version=6.1-preview.1"
$refName = 'refs/heads/development'
$body = @{
    resources    = @{
        repositories = @{
            self = @{
                refName = $refName
            }
        }
    }
    previewRun   = $true
    yamlOverride = $ymlFile
}
$body = $body | ConvertTo-Json -Depth 4
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "anything", $accessToken)))
$response = Invoke-RestMethod -Uri $address -Method Post -Credential $credential `
    -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo) } `
    -ContentType "application/json" `
    -Body $body 
$response.finalYaml | Out-File -FilePath $outputPath
if ($outputToConsole) { $response }