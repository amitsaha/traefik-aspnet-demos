$ApplicationName = "aspnetframework-demo"
$Image="amitsaha/aspnetframework-demo"
docker run --label "app=${ApplicationName}" -d $Image