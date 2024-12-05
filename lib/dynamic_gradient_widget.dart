import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dynamic_theme_provider.dart';

/// A widget that provides a dynamic gradient background.
///
/// This widget listens to the `DynamicThemeProvider` to get the current gradient
/// and applies it as the background for the child widget.
class DynamicGradientBackground extends StatelessWidget {
  final Widget child;

  /// Creates a `DynamicGradientBackground` widget.
  ///
  /// The [child] is the widget that will be displayed on top of the dynamic background.
  const DynamicGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Retrieve the current gradient from the provider.
    final gradient = Provider.of<DynamicThemeProvider>(context).currentGradient;

    return Container(
      // Apply the retrieved gradient as the background decoration.
      decoration: BoxDecoration(gradient: gradient),
      // The child widget is rendered inside this container.
      child: child,
    );
  }
}
