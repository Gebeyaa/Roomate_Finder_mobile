import 'package:flutter/material.dart';

import 'route_builder.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routes = RouteBuilder.getRoutes();

    if (routes.containsKey(settings.name)) {
      return MaterialPageRoute(
        builder: routes[settings.name]!,
        settings: settings,
      );
    }

    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
    );
  }
}
