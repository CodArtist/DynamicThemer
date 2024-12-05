import 'package:dynamic_theme/theme_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dynamic_theme_provider.dart';

/// A widget that provides a theme switching button.
///
/// This widget listens to the `DynamicThemeProvider` to determine the current theme
/// and allows the user to toggle between light and dark themes.
class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current theme provider to access the current theme and gradient.
    final themeProvider = Provider.of<DynamicThemeProvider>(context);

    return IconButton(
      // Set the icon based on the current theme (light or dark).
      icon: Icon(
        themeProvider.currentTheme.brightness == Brightness.light
            ? Icons.dark_mode // Light theme, show dark mode icon.
            : Icons.light_mode, // Dark theme, show light mode icon.
      ),
      onPressed: () {
        // Switch to the opposite theme when the button is pressed.
        themeProvider.switchTheme(
          themeProvider.currentTheme.brightness == Brightness.light
              ? AppThemes.darkTheme // Switch to dark theme.
              : AppThemes.lightTheme, // Switch to light theme.
          themeProvider.currentTheme.brightness == Brightness.light
              ? AppThemes.darkGradient // Switch to dark gradient.
              : AppThemes.lightGradient, // Switch to light gradient.
        );
      },
    );
  }
}
