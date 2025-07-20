import 'package:flutter/material.dart';
import 'package:weatherapptask/models/weather_entry.dart';

class WeatherCardWidget extends StatelessWidget {
  final WeatherEntry entry;
  final VoidCallback? onSave;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final bool fromHome;

  const WeatherCardWidget({
    Key? key,
    required this.entry,
     this.onSave,
    this.onDelete,
    this.onTap,
    required this.fromHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.cityName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(children: [
                const Icon(Icons.thermostat_outlined, size: 28, color: Colors.orange),
                const SizedBox(width: 8),
                Text('${entry.temperature} °C', style: const TextStyle(fontSize: 20)),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                const Icon(Icons.cloud_outlined, size: 28, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text(entry.condition, style: const TextStyle(fontSize: 20)),
              ]),
              const SizedBox(height: 20),

              if (!fromHome)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onSave,
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                ),

              if (fromHome && onDelete != null)
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text('Delete', style: TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
