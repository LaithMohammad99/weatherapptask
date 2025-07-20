import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapptask/view_models/auth_view_model.dart';
import 'package:weatherapptask/view_models/weather_view_model.dart';

import 'injection_container.dart';
import 'screens/home_screen.dart';

void main() {
  setupLocator("https://api.openweathermap.org");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => AuthController()),
        ChangeNotifierProvider(create: (BuildContext context) => WeatherViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  HomeScreen(),
      ),
    );
  }
}


