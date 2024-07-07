# Define the coordinates for location
$latitude = 35.1595
$longitude = -84.8766

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
