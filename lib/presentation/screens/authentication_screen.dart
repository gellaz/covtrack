import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/authentication/authentication_bloc.dart';
import '../../business/blocs/trips/trips_bloc.dart';
import '../../business/repositories/trips/firestore_trips_repository.dart';
import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';
import 'root_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (_, state) {
        if (state is Uninitialized) {
          return SplashScreen();
        }
        if (state is Unauthenticated) {
          return LoginScreen();
        }
        if (state is Authenticated) {
          return BlocProvider(
            child: RootScreen(),
            create: (_) => TripsBloc(
              tripsRepository: FirestoreTripsRepository(uid: state.user.uid),
            )..add(LoadTrips()),
          );
        }
        return Container();
      },
    );
  }
}
