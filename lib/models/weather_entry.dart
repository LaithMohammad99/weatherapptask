class WeatherEntry {
  final String cityName;
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;

  WeatherEntry({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
  });

  // تحويل من JSON (API)
  factory WeatherEntry.fromJson(Map<String, dynamic> json) {
    return WeatherEntry(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }

  // تحويل إلى Map (للتخزين المحلي في SQLite)
  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'temperature': temperature,
      'condition': condition,
      'humidity': humidity,
      'windSpeed': windSpeed,
    };
  }

  // تحويل من Map إلى كائن (للقراءة من SQLite)
  factory WeatherEntry.fromMap(Map<String, dynamic> map) {
    return WeatherEntry(
      cityName: map['cityName'],
      temperature: (map['temperature'] as num).toDouble(),
      condition: map['condition'],
      humidity: map['humidity'],
      windSpeed: (map['windSpeed'] as num).toDouble(),
    );
  }
}
