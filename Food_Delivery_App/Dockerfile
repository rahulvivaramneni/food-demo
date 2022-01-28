# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY Food_Delivery_App_API/*.csproj ./Food_Delivery_App_API/
RUN dotnet restore

# copy everything else and build app
COPY Food_Delivery_App_API/. ./Food_Delivery_App_API/
WORKDIR /source/Food_Delivery_App_API
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "Food_Delivery_App_API.dll"]