import 'package:flutter/material.dart';
// Widgets
import 'reponsive_widget.dart';

// Create Route and wrap it with responsive widget, for responsivity (obviously)
MaterialPageRoute createRoute(Widget route, String routeName) {
  return MaterialPageRoute(
    builder: (context) => ResponsiveWidget(child: route),
    settings: RouteSettings(name: routeName),
  );
}
