import 'package:flutter/material.dart';

import '../../presentation/home/home_page.dart';
import '../../presentation/second/second_page.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      case Routes.second:
        return MaterialPageRoute(
          builder: (context) => SecondPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Route not found'),
            ),
          ),
        );
    }
  }
}
