# ASP.NET Framework Demo

This demo demonstrates running a ASP.NET framework web application in a docker container and using
Traefik as a reverse proxy.

## Windows server on AWS

- AMI: Windows_Server-2016-English-Core-Base-2018.09.15 (ami-07e79e32080cc54c9)


```
PS C:\Users\Administrator> Install-Package Docker -ProviderName DockerMsftProvider -Force
WARNING: Cannot verify the file SHA256. Deleting the file.
WARNING: C:\Users\ADMINI~1\AppData\Local\Temp\2\DockerMsftProvider\Docker-18-09-0.zip does not exist
Install-Package : Cannot find path 'C:\Users\ADMINI~1\AppData\Local\Temp\2\DockerMsftProvider\Docker-18-09-0.zip' because it does not exist.
At line:1 char:1
+ Install-Package Docker -ProviderName DockerMsftProvider -Force
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (C:\Users\ADMINI...ker-18-09-0.zip:String) [Install-Package], Exception
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.RemoveItemCommand,Microsoft.PowerShell.PackageManagement.Cmdlets.InstallPackage

PS C:\Users\Administrator>
```

## Useful links

- [Azure pipelines + docker](https://docs.microsoft.com/en-us/azure/devops/pipelines/languages/docker?view=vsts&tabs=yaml)
