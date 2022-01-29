#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["Food_Delivery_App_API/Food_Delivery_App_API.csproj", "Food_Delivery_App_API/"]
RUN dotnet restore "Food_Delivery_App_API/Food_Delivery_App_API.csproj"
COPY . .
WORKDIR "/src/Food_Delivery_App_API"
RUN dotnet build "Food_Delivery_App_API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Food_Delivery_App_API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Food_Delivery_App_API.dll"]