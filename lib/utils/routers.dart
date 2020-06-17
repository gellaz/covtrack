import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business/blocs/trips/trips_bloc.dart';
import '../presentation/screens/change_password_screen.dart';
import '../presentation/screens/delete_account_screen.dart';
import '../presentation/screens/destination_picker_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/news_screen.dart';
import '../presentation/screens/old_trips_screen.dart';
import '../presentation/screens/qr_screen.dart';
import '../presentation/screens/settings_screen.dart';
import '../presentation/screens/trip_details_screen.dart';

abstract class Router {
  final String initialRoute;

  const Router({this.initialRoute});

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
      case DestinationPickerScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.bloc<TripsBloc>(),
            child: DestinationPickerScreen(),
          ),
        );
        break;
      case TripDetailsScreen.routeName:
        var destination = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.bloc<TripsBloc>(),
            child: TripDetailsScreen(destination),
          ),
        );
        break;
      case OldTripsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.bloc<TripsBloc>(),
            child: OldTripsScreen(),
          ),
        );
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

class NewsRouter implements Router {
  @override
  String get initialRoute => NewsScreen.routeName;

  @override
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NewsScreen.routeName:
        return MaterialPageRoute(builder: (_) => NewsScreen());
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
        break;
    }
  }
}

class SettingsRouter implements Router {
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
      case DeleteAccountScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.bloc<TripsBloc>(),
            child: DeleteAccountScreen(),
          ),
        );
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
        break;
    }
  }
}
