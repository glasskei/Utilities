# Prompt for the ZIP code
$zipCode = Read-Host "Enter ZIP code"

# Define the Zippopotam.us API URL for getting latitude and longitude from ZIP code
$zipApiUrl = "http://api.zippopotam.us/us/$zipCode"
$zipApiResponse = Invoke-RestMethod -Uri $zipApiUrl

# Extract latitude and longitude from the response
$latitude = $zipApiResponse.places[0].latitude
$longitude = $zipApiResponse.places[0].longitude

# Convert latitude and longitude to the format required by the NWS API
$latitude = [double]$latitude
$longitude = [double]$longitude

# Get the metadata for the location, which includes the forecast URL
$metadataUrl = "https://api.weather.gov/points/$latitude,$longitude"
$metadataResponse = Invoke-RestMethod -Uri $metadataUrl

# Extract the hourly forecast URL from the metadata
$hourlyForecastUrl = $metadataResponse.properties.forecastHourly

# Get the hourly weather forecast
$forecastResponse = Invoke-RestMethod -Uri $hourlyForecastUrl

# Display the forecast
$forecastResponse.properties.periods | ForEach-Object {
    Write-Output "Time: $($_.startTime)"
    Write-Output "Temperature: $($_.temperature) $($_.temperatureUnit)"
    Write-Output "Wind: $($_.windSpeed) $($_.windDirection)"
    Write-Output "Forecast: $($_.shortForecast)"
    Write-Output "-----------------------------"
}