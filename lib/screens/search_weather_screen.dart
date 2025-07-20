import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapptask/models/weather_entry.dart';
import 'package:weatherapptask/view_models/weather_view_model.dart';
import 'package:weatherapptask/widgets/weather_card.dart';

import 'weather_details_screen.dart'; // افترض عندك هذا ويدجت

class SearchWeatherScreen extends StatefulWidget {
  const SearchWeatherScreen({Key? key}) : super(key: key);

  @override
  State<SearchWeatherScreen> createState() => _SearchWeatherScreenState();
}

class _SearchWeatherScreenState extends State<SearchWeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final weatherVM = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Search Weather',style: TextStyle(color: Colors.white),)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'City Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) {
                weatherVM.getWeather(_cityController.text);
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: weatherVM.isLoading
                    ? null
                    : () {
                  weatherVM.getWeather(_cityController.text);
                },
                child: weatherVM.isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text('Search'),
              ),
            ),
            const SizedBox(height: 24),

            // Error message
            if (weatherVM.error != null)
              Text(
                weatherVM.error!,
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),

            // Weather result card
            if (weatherVM.weatherEntry != null)
              WeatherCardWidget(
                entry: weatherVM.weatherEntry!,
                onSave: () async {
                  await weatherVM.saveWeatherLocally();
                },
                fromHome: false,
                onTap: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WeatherDetailsScreen(entry:  weatherVM.weatherEntry!),
                  ),
                ),
              )

          ],
        ),
      ),
    );
  }

}
