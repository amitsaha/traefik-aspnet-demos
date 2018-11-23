$template=Get-Content "C:\traefik\rules.toml.template" -Encoding UTF8 -Raw
$site1=docker ps --filter "health=healthy" --filter "label=app=apsnetframwork-demo-site1" --format '{{.ID}}'
if ($site1)
{
    $apiIP=docker inspect $site1 --format '{{ .NetworkSettings.Networks.nat.IPAddress}}'
} else {
    Write-Output "--- Site1 Container not ready"
    exit 1
}

$site2=docker ps --filter "health=healthy" --filter "label=app=apsnetframwork-demo-site2" --format '{{.ID}}'
if ($site1)
{
    $adminIP=docker inspect $site2 --format '{{ .NetworkSettings.Networks.nat.IPAddress}}'
} else {
    Write-Output "--- Site2 Container not ready"
    exit 1
}

$expanded = $ExecutionContext.InvokeCommand.ExpandString($template)
[System.IO.File]::WriteAllLines("C:\traefik\rules.toml", $expanded)
