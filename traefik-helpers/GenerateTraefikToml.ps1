$template=Get-Content "C:\traefik\rules.toml.template" -Encoding UTF8 -Raw


$site1=docker ps --filter "health=healthy" --filter "label=app=amitsaha/apsnetframwork-demon" --filter "label=version=${NewImageTag}" --format '{{.ID}}'
if ($site1)
{
    $siteIP=docker inspect $site1 --format '{{ .NetworkSettings.Networks.nat.IPAddress}}'
} else {
    Write-Output "--- Site1 Container not ready"
    exit 1
}

$expanded = $ExecutionContext.InvokeCommand.ExpandString($template)
[System.IO.File]::WriteAllLines("C:\traefik\rules.toml", $expanded)