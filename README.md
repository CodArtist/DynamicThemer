# Dynamic Themer
![alt text](https://github.com/CodArtist/DynamicThemer/blob/main/InShot_20241205_150913090.gif?raw=true)

**DynamicThemer** is a Flutter package that enables real-time dynamic theming in your Flutter apps. With features like theme switching based on user actions, time of day, or system preferences, it provides developers with an intuitive way to create engaging and visually appealing apps.

## Features
1. **Dynamic Light and Dark Mode Switching**
2. **Time-Based Theme Trigger** (e.g., light mode during the day, dark mode at night)
3. **Dynamic Gradient Backgrounds**
4. **Theming for Text, Buttons, and Other UI Components**
5. **Theme switching based on system preference**:
6. **Easy Integration with Custom Widgets**:

   - `DynamicThemeWrapper`
   - `ThemeSwitcher`
   - `DynamicGradientBackground`

---

## Example App (Clock)

<div align="center">
  <video src="https://github.com/user-attachments/assets/9e594a0b-734b-424b-ab99-167651222c23" width="400" />
</div>                                                  

---

## Usage

Wrap your app with the `DynamicThemeWrapper` and use the provided widgets to implement dynamic theming.

### Example

Below is a basic implementation:

#### `main.dart`
```dart
import 'package:flutter/material.dart';
import 'package:dynamic_themer/dynamic_themer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicThemeWrapper(
      child: Builder(
        builder: (context) {
          final themeProvider = Provider.of<DynamicThemeProvider>(context);
          return MaterialApp(
            theme: themeProvider.currentTheme,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicGradientBackground(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dynamic Theming'),
          actions: [ThemeSwitcher()],
        ),
        body: Center(
          child: Text('Hello, Dynamic Themes!'),
        ),
      ),
    );
  }
}
```

---

## Widgets

### 1. **DynamicThemeWrapper**
Wrap your app in this widget to enable dynamic theming:
```dart
DynamicThemeWrapper(

    // ************************* Define Light Theme (optional) uses default light theme of package *************************
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
      // ************************* Define Dark Theme (optional) uses default dark theme of package *************************
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

      // ************************* Define Light Gradient Theme (optional) uses default light gradient theme of package *************************

      lightGradient: const LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

      // ************************* Define Dark Gradient Theme (optional) uses default dark gradient theme of package *************************

      darkGradient:  const LinearGradient(
          colors: [Color(0xff0D324D), Color(0xff7F5A83)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

      // Optional: uses the system theme is set to true and turns off auto theme change with time feature of the package.
      setSystemPreferenceTheme: false,
 
  child: MyApp(),
)
```

### 2. **ThemeSwitcher**
Add a theme switch button to your UI:
```dart
ThemeSwitcher()
```

### 3. **DynamicGradientBackground**
Add a dynamic gradient background to your UI:
```dart
DynamicGradientBackground(
  child: YourWidget(),
)
```

---
To use the **DynamicThemer** package locally in your example project, follow these instructions for setting up the package locally.

---

### Example Project Setup (Using the Package Locally)

1. **Clone the Repository**:
   Clone the repository containing the package:
   ```bash
   git clone https://github.com/CodArtist/DynamicThemer.git
   ```

2. **Set Up the Example Project (this comes with an example project)**:
   The folder structure should look like this:
   ```
   DynamicThemer/
   ├── lib/
   │   ├── dynamic_theme_provider.dart
   │   ├── theme_models.dart
   │   ├── dynamic_themer.dart
   │   ├── theme_switcher_widget.dart
   │   ├── dynamic_gradient_widget.dart
   ├── pubspec.yaml
   ├── example/
   │   ├── lib/
   │   │   ├── main.dart
   │   ├── pubspec.yaml
   ```
3. **Run flutter pub get**:
   In the main directory run:
   ```bash
   cd DynamicThemer
   flutter pub get
   ```
   
3. **Run the Example Project**:
   Navigate to the `example` folder and run the app:
   ```bash
   cd example
   flutter run
   ```

---

## API Documentation

### Classes and Methods

#### 1. **DynamicThemeProvider**
Manages the application's theme and gradient state. It listens for system theme changes or time-based theme switching.
- **`ThemeData get currentTheme`**: Returns the current theme data (`lightTheme` or `darkTheme`).
- **`Gradient get currentGradient`**: Returns the current gradient (`lightGradient` or `darkGradient`).
- **`void switchTheme(ThemeData theme, Gradient gradient)`**: Switches the theme and gradient manually. 
- **`void switchBasedOnTime()`**: Automatically switches the theme based on the time of day (light theme during the day, dark theme at night).
- **`void _updateThemeBasedOnSystemPreferences()`**: Internal method that updates the theme based on the system's brightness setting (light or dark mode).
- **`void _initializeTimeListener()`**: Initializes a periodic listener that checks the current time every 10 seconds to determine whether to switch the theme.
- **`void _updateThemeBasedOnTime()`**: Internal method that checks the current time and updates the theme accordingly (light theme for 6 AM to 6 PM, dark theme for the rest of the day).
- **`void dispose()`**: Cancels the timer and removes any system theme observers when the provider is disposed.

#### 2. **AppThemes**
Provides pre-defined themes and gradients used by `DynamicThemeProvider`.
- **`AppThemes.lightTheme`**: The light theme for the application.
- **`AppThemes.darkTheme`**: The dark theme for the application.
- **`AppThemes.lightGradient`**: The light gradient used for the background.
- **`AppThemes.darkGradient`**: The dark gradient used for the background.
- **`void initialize({ThemeData? lightThemeData, ThemeData? darkThemeData, Gradient? lightGradientData, Gradient? darkGradientData})`**: Initializes the `AppThemes` with custom light and dark theme data and gradients. 

#### 3. **DynamicThemeWrapper**
A widget that wraps the app and provides theme management by initializing the `DynamicThemeProvider`. It can optionally use the system theme preferences for automatic theme switching.
- **`const DynamicThemeWrapper({super.key, required this.child, this.setSystemPreferenceTheme = false, this.lightTheme, this.darkTheme, this.lightGradient, this.darkGradient})`**: The constructor for `DynamicThemeWrapper`, allowing optional theme and gradient customization and enabling system-based theme switching.
- **`Widget build(BuildContext context)`**: Builds the widget tree, wrapping the child widget in a `ChangeNotifierProvider` for `DynamicThemeProvider`.

#### 4. **SystemThemeObserver**
A `WidgetsBindingObserver` used to listen for changes in the system's theme preference (light or dark mode).
- **`SystemThemeObserver(DynamicThemeProvider themeProvider)`**: Constructor that takes the `DynamicThemeProvider` to update the theme based on system changes.
- **`void didChangePlatformBrightness()`**: Called when the platform's theme preference changes, updating the theme accordingly.

