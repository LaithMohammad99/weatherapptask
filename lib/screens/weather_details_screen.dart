import 'package:flutter/material.dart';
import 'package:weatherapptask/models/weather_entry.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final WeatherEntry entry;

  const WeatherDetailsScreen({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.cityName,style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Icon(Icons.location_city, size: 60, color: Colors.blueGrey),
                const SizedBox(height: 16),
                Text(
                  entry.cityName,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const Divider(height: 30, thickness: 1),
                _buildInfoTile(Icons.thermostat_outlined, "Temperature", "${entry.temperature} °C"),
                _buildInfoTile(Icons.cloud_outlined, "Condition", entry.condition),
                _buildInfoTile(Icons.water_drop_outlined, "Humidity", "${entry.humidity}%"),
                _buildInfoTile(Icons.air_outlined, "Wind Speed", "${entry.windSpeed} m/s"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 30),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        trailing: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
