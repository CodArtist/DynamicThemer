import 'package:dynamic_theme/dynamic_themer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the app with dynamic theme handling.
    return DynamicThemeWrapper(
      // ************************* Define Light Theme *************************
      lightTheme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue, // AppBar background for light mode.
          foregroundColor: Color.fromARGB(228, 255, 255, 255), // Text color.
          elevation: 0, // Removes shadow for a flat appearance.
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(228, 255, 255, 255)),
        ),
      ),
      // ************************* Define Dark Theme *************************
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // AppBar background for dark mode.
          foregroundColor: Color.fromARGB(255, 133, 120, 206), // Text color.
          elevation: 0, // Removes shadow for a flat appearance.
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(255, 175, 161, 255)),
        ),
      ),

      // Optional: uses the system theme is set to true and turns off auto theme change with time feature of the package.
      setSystemPreferenceTheme: false,

      // Pass the app's theme to the widget tree.
      child: Builder(
        builder: (context) {
          final themeProvider = Provider.of<DynamicThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.currentTheme,
            home: const HomeScreen(), // Define the app's home screen.
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicGradientBackground(
      // Wraps the Scaffold with a gradient background.
      child: Scaffold(
        backgroundColor: Colors.transparent, // Ensure gradient visibility.
        appBar: AppBar(
          title: const Text('Clock'),
          backgroundColor: Colors.transparent, // Override app bar color.
          actions: const [
            ThemeSwitcher(), // Adds a theme switching button.
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DigitalClock(), // Display the digital clock widget.
            ],
          ),
        ),
      ),
    );
  }
}

class DigitalClock extends StatefulWidget {
  const DigitalClock({super.key});

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late String _currentTime; // Stores the current time as a string.
  late Timer _timer; // Timer to update the clock every second.

  @override
  void initState() {
    super.initState();
    _currentTime = _formatTime(DateTime.now()); // Initialize current time.
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = _formatTime(DateTime.now()); // Update time every second.
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed.
    super.dispose();
  }

  // Formats the DateTime object to a `HH:mm:ss` string format.
  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Text(
      _currentTime,
      style: TextStyle(
        fontFamily: 'DigitalClock', // Applies custom digital font.
        fontSize: 40.0, // Sets font size for the clock.
        fontWeight: FontWeight.bold, // Bold styling for better readability.
        letterSpacing: 2.0, // Adds spacing between characters.
        color: textColor, // Matches text color with the current theme.
      ),
    );
  }
}
