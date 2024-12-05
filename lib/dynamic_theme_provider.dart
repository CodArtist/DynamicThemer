import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_models.dart';

class DynamicThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = AppThemes.lightTheme;
  Gradient _currentGradient = AppThemes.lightGradient;
  Timer? _timer; // Timer for periodic time checks
  final bool setSystemPreferenceTheme;

  DynamicThemeProvider({this.setSystemPreferenceTheme = false}) {
    if (setSystemPreferenceTheme) {
      _updateThemeBasedOnSystemPreferences();
    } else {
      _initializeTimeListener(); // Start time listener for time-based theming
    }
  }

  ThemeData get currentTheme => _currentTheme;
  Gradient get currentGradient => _currentGradient;

  /// Updates theme based on the system's current preference
  void _updateThemeBasedOnSystemPreferences() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    if (brightness == Brightness.dark) {
      _currentTheme = AppThemes.darkTheme;
      _currentGradient = AppThemes.darkGradient;
    } else {
      _currentTheme = AppThemes.lightTheme;
      _currentGradient = AppThemes.lightGradient;
    }
    notifyListeners();
    // Listen for future changes in system preferences
    WidgetsBinding.instance.addObserver(SystemThemeObserver(this));
  }

  /// Switches theme based on the current time
  void _updateThemeBasedOnTime() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 18) {
      if (_currentTheme != AppThemes.lightTheme) {
        _currentTheme = AppThemes.lightTheme;
        _currentGradient = AppThemes.lightGradient;
        notifyListeners();
      }
    } else {
      if (_currentTheme != AppThemes.darkTheme) {
        _currentTheme = AppThemes.darkTheme;
        _currentGradient = AppThemes.darkGradient;
        notifyListeners();
      }
    }
  }

  /// Initializes a periodic timer to check the time every 10 seconds
  void _initializeTimeListener() {
    _updateThemeBasedOnTime(); // Ensure theme is set correctly on app start
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _updateThemeBasedOnTime();
    });
  }

  /// Cancel the timer and observers when the provider is disposed
  @override
  void dispose() {
    _timer?.cancel();
    if (setSystemPreferenceTheme) {
      WidgetsBinding.instance.removeObserver(SystemThemeObserver(this));
    }
    super.dispose();
  }

  void switchTheme(ThemeData theme, Gradient gradient) {
    _currentTheme = theme;
    _currentGradient = gradient;
    notifyListeners();
  }
}

/// Observer to listen to system theme changes
class SystemThemeObserver extends WidgetsBindingObserver {
  final DynamicThemeProvider themeProvider;

  SystemThemeObserver(this.themeProvider);

  @override
  void didChangePlatformBrightness() {
    themeProvider._updateThemeBasedOnSystemPreferences();
  }
}

class DynamicThemeWrapper extends StatelessWidget {
  final Widget child;
  final bool setSystemPreferenceTheme;
  final ThemeData? lightTheme;
  final ThemeData? darkTheme;
  final Gradient? lightGradient;
  final Gradient? darkGradient;

  const DynamicThemeWrapper({
    super.key,
    required this.child,
    this.setSystemPreferenceTheme = false,
    this.lightTheme,
    this.darkTheme,
    this.lightGradient,
    this.darkGradient,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize themes and gradients
    AppThemes.initialize(
      lightThemeData: lightTheme,
      darkThemeData: darkTheme,
      lightGradientData: lightGradient,
      darkGradientData: darkGradient,
    );

    return ChangeNotifierProvider(
      create: (_) => DynamicThemeProvider(
        setSystemPreferenceTheme: setSystemPreferenceTheme,
      ),
      child: child,
    );
  }
}
