import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapptask/view_models/weather_view_model.dart';
import 'package:weatherapptask/widgets/weather_card.dart';
import 'search_weather_screen.dart';
import 'weather_details_screen.dart'; // تأكد من المسار

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<WeatherViewModel>(context, listen: false).loadSavedWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherVM = Provider.of<WeatherViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text('Saved Weather',style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: weatherVM.savedWeatherList.isEmpty
            ? const Center(child: Text('No saved weather yet.'))
            : ListView.builder(
                itemCount: weatherVM.savedWeatherList.length,
                itemBuilder: (context, index) {
                  final entry = weatherVM.savedWeatherList[index];
                  return WeatherCardWidget(
                    entry: entry,
                    fromHome: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WeatherDetailsScreen(entry: entry),
                        ),
                      );
                    },
                    onDelete: () async {
                      await weatherVM.deleteWeatherEntry(entry);
                    },
                  );
                },
              ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SearchWeatherScreen()),
          );
        },
        tooltip: 'Search Weather',
        child: const Icon(Icons.search),
      ),
    );
  }
}
