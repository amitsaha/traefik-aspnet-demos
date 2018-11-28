param(     
     [Parameter(Mandatory=$True)][string]$GitHash
)

$ApplicationName = "aspnetframework-demo-site1"
$Image="amitsaha/aspnetframework-demo-site1:$GitHash"
docker run `
      --label "traefik.backend=site1" `
      --label "traefik.frontend.rule=Host:site1.echorand.me"  `
      --label "traefik.port=80" `
      --label "app=${ApplicationName}" `
      --label "version=$GitHash" -d $Image

$ApplicationName = "aspnetframework-demo-site2"
$Image="amitsaha/aspnetframework-demo-site2:$GitHash"
docker run `
      --label "traefik.backend=site2" `
      --label "traefik.frontend.rule=Host:site2.echorand.me"  `
      --label "traefik.port=80" `
      --label "app=${ApplicationName}" `
      --label "version=$GitHash" -d $Image