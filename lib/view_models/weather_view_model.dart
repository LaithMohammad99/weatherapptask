import 'package:flutter/widgets.dart';
import 'package:weatherapptask/core/BaseApp.dart';
import 'package:weatherapptask/core/weather_db_helper.dart';
import 'package:weatherapptask/models/weather_entry.dart';

class WeatherViewModel extends BaseApp{
  WeatherEntry? weatherEntry;
  bool isLoading = false;
  String? error;
  List<WeatherEntry> savedWeatherList = [];

  Future<void> getWeather(String cityName) async {
    isLoading = true;
    error = null;
    notifyListeners();
    final response = await apiClient.get(
      '/data/2.5/weather',
      queryParameters: {
        'q': cityName,
        'units': 'metric',
      },
    );

    isLoading = false;

    if (response == null || response.statusCode != 200) {
      error = 'Failed to fetch weather data';
      notifyListeners();
      return;
    }

    try {
      final data = response.data;
      weatherEntry = WeatherEntry.fromJson(data);
    } catch (e) {
      error = 'Error parsing weather data';
    }

    notifyListeners();
  }


  Future<void> saveWeatherLocally() async {
    if (weatherEntry != null) {
      await WeatherDBHelper().insertWeather(weatherEntry!);
      loadSavedWeather();
      print('Weather saved locally: ${weatherEntry!.cityName}');
      notifyListeners();
    }
  }

  Future<List<WeatherEntry>> getSavedWeatherList() async {
    print('Total saved entries: ${savedWeatherList.length}');
    return await WeatherDBHelper().getAllWeather();
  }
  void clear() {
    weatherEntry = null;
    error = null;
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadSavedWeather() async {
    savedWeatherList = await WeatherDBHelper().getAllWeather();
    print('Total saved entries: ${savedWeatherList.length}');
    notifyListeners();
}

  Future<void> deleteWeatherEntry(WeatherEntry entry) async {
    await WeatherDBHelper().deleteWeather(entry.cityName); // delete by city name
    await loadSavedWeather(); // reload after delete
    notifyListeners();
  }
  }