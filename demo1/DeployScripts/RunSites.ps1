$ApplicationName = "aspnetframework-demo-site1"
$Image="amitsaha/aspnetframework-demo-site1"
docker run --label "app=${ApplicationName}" -d $Image

$ApplicationName = "aspnetframework-demo-site2"
$Image="amitsaha/aspnetframework-demo-site2"
docker run --label "app=${ApplicationName}" -d $Image
