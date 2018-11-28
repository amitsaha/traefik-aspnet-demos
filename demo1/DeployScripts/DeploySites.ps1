param(     
     [Parameter(Mandatory=$True)][string]$GitHash
)

# Deploy the new version
$Image1="amitsaha/aspnetframework-demo-site1"
docker run `
      --label "traefik.backend=site1" `
      --label "traefik.frontend.rule=Host:site1.echorand.me"  `
      --label "traefik.port=80" `
      --label "traefik.backend.healthcheck.path=/" `
      --label "app=${Image1}" `
      --label "version=$GitHash" -d "$($Image1):$($GitHash)"

$ApplicationName = "aspnetframework-demo-site2"
$Image2="amitsaha/aspnetframework-demo-site2"
docker run `
      --label "traefik.backend=site2" `
      --label "traefik.frontend.rule=Host:site2.echorand.me"  `
      --label "traefik.port=80" `
      --label "traefik.backend.healthcheck.path=/" `
      --label "app=${Image2}" `
      --label "version=$GitHash" -d "$($Image2):$($GitHash)"

# For each image, wait for a new container to become healthy and kill the old one
$images=@($Image1, $Image2)
foreach ($image in $images)
{
    $container=docker ps --filter "label=app=${image}" --filter "label=version=${GitHash}" --format '{{.ID}}'
    $health=docker inspect --format '{{ .State.Health.Status }}' $container

    while ($health -ne 'healthy') {        
      $health=docker inspect --format '{{ .State.Health.Status }}' $container
      Start-Sleep -s 20
    }
    $OldContainer=docker ps --filter "label=app=${image}" --filter before=$container --format '{{.ID}}'
    if ($OldContainer)
    {
          Write-Output "Shutting down $image"
          docker exec $OldContainer powershell -Command Stop-WebAppPool -Name "DefaultAppPool"
          Start-Sleep -s 30
          docker rm -f $OldContainer
    }
}