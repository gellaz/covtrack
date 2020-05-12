import 'package:flutter/material.dart';

import '../screens/donate/donate_detail_screen.dart';
import '../screens/donate/donate_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/info/info_screen.dart';
import '../screens/places_picker/places_picker_screen.dart';

abstract class Router {
  final String initialRoute;

  Router({this.initialRoute});

  Route<dynamic> generateRoute(RouteSettings settings);
}

class HomeRouter implements Router {
  @override
  String get initialRoute => '/home';

  @override
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case '/home/place-picker':
        return MaterialPageRoute(builder: (_) => PlacesPickerScreen());
        break;
    }
  }
}

class InfoRouter implements Router {
  @override
  String get initialRoute => '/info';

  @override
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/info':
        return MaterialPageRoute(builder: (_) => InfoScreen());
        break;
    }
  }
}

class DonateRouter implements Router {
  @override
  String get initialRoute => '/donate';

  @override
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/donate':
        return MaterialPageRoute(builder: (_) => DonateScreen());
        break;
      case '/donate/detail':
        return MaterialPageRoute(builder: (_) => DonateDetailScreen());
        break;
    }
  }
}
