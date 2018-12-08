FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:2.1-aspnetcore-runtime
RUN apt-get -y update && apt-get -y install curl
WORKDIR /app
COPY --from=build-env /app/out .

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
# Assembly name is the same as the project name
ENTRYPOINT ["dotnet", "demo2.dll"]
