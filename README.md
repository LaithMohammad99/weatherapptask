# weatherapptask

A new Flutter project.

---

## Project Structure & Core Components

This project follows the MVVM pattern with Provider state management and uses Dio for API calls.

### Core files and responsibilities:

- **BaseAppClient**  
  Handles all network requests using Dio. It automatically appends the API key and other headers to every request.

- **AuthController**  
  Holds the API key and handles user authentication state (if needed). Currently provides the OpenWeatherMap API key.

- **WeatherViewModel**  
  Acts as the bridge between UI and data.
    - Fetches weather data from the API using `BaseAppClient`.
    - Stores the current weather result (`weatherEntry`).
    - Handles loading and error states.
    - Manages saving and loading weather data locally via SQLite.

- **WeatherEntry Model**  
  Represents the weather data fetched from the API or stored locally.

- **UI Screens**
    - `SearchWeatherScreen`: allows searching weather by city name, showing results, saving locally, and displaying saved weather entries.
    - `WeatherDetailsScreen`: shows detailed weather info for a selected entry.

---

## Adding Images to README

To include screenshots or images in this README:

1. Place your image files inside the project folder, for example:  
   `assets/images/screenshot_weather_app.png`

2. Reference the image in this README like so:

   ```md
   ![Weather App Screenshots](assets/images/one_screenshot_weather_app.png)
   ![Weather App Screenshots](assets/images/tow_screenshot_weather_app.png)
   ![Weather App Screenshots](assets/images/three_screenshot_weather_app.png)
   ![Weather App Screenshots](assets/images/four_screenshot_weather_app.png)

