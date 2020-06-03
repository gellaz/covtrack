import 'package:flutter/material.dart';

import '../presentation/screens/change_password_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/info_screen.dart';
import '../presentation/screens/new_trip_screen.dart';
import '../presentation/screens/old_trips_screen.dart';
import '../presentation/screens/qr_screen.dart';
import '../presentation/screens/settings_screen.dart';
import '../presentation/screens/trip_details_screen.dart';

abstract class Router {
  final String initialRoute;

  Router({this.initialRoute});

  Route<dynamic> generateRoute(RouteSettings settings);
}

class HomeRouter implements Router {
  @override
  String get initialRoute => HomeScreen.routeName;

  @override
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case NewTripScreen.routeName:
        return MaterialPageRoute(builder: (_) => NewTripScreen());
        break;
      case TripDetailsScreen.routeName:
        var destination = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => TripDetailsScreen(destination),
        );
        break;
      case OldTripsScreen.routeName:
        return MaterialPageRoute(builder: (_) => OldTripsScreen());
        break;
      case QrScreen.routeName:
        var activeTrip = settings.arguments;
        return MaterialPageRoute(builder: (_) => QrScreen(activeTrip));
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
        break;
    }
  }
}

class InfoRouter implements Router {
  @override
  String get initialRoute => InfoScreen.routeName;

  @override
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case InfoScreen.routeName:
        return MaterialPageRoute(builder: (_) => InfoScreen());
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
        break;
    }
  }
}

class DonateRouter implements Router {
  @override
  String get initialRoute => SettingsScreen.routeName;

  @override
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SettingsScreen.routeName:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
        break;
      case ChangePasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
        break;
    }
  }
}
