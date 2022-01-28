FROM mcr.microsoft.com/dotnet/aspnet:5.0-focal AS base
WORKDIR /app
EXPOSE 80
FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS build
WORKDIR /src
COPY ["Food_Delivery_App_API.csproj", "./"]
RUN dotnet restore "./Food_Delivery_App_API.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "Food_Delivery_App_API.csproj" -c Release -o /app/build
FROM build AS publish
RUN dotnet publish "Food_Delivery_App_API.csproj" -c Release -o /app/publish
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Food_Delivery_App_API.dll"]