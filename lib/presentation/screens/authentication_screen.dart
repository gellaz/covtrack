import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/authentication/authentication_bloc.dart';
import '../../business/blocs/old_destinations/old_destinations_bloc.dart';
import '../../business/blocs/trips/trips_bloc.dart';
import '../../business/repositories/old_destinations/firestore_old_destinations_repository.dart';
import '../../business/repositories/old_destinations/old_destinations_repository.dart';
import '../../business/repositories/trips/firestore_trips_repository.dart';
import '../../business/repositories/trips/trips_repository.dart';
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
          final String userId = state.user.uid;
          final TripsRepository tripsRepository =
              FirestoreTripsRepository(uid: userId);
          final OldDestinationsRepository oldDestinationsRepository =
              FirestoreOldDestinationsRepository(uid: userId);

          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (_) => tripsRepository,
              ),
              RepositoryProvider(
                create: (_) => oldDestinationsRepository,
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => TripsBloc(
                    tripsRepository: tripsRepository,
                  )..add(LoadTrips()),
                ),
                BlocProvider(
                  create: (_) => OldDestinationsBloc(
                    oldDestinationsRepository: oldDestinationsRepository,
                  )..add(LoadOldDestinations()),
                ),
              ],
              child: RootScreen(),
            ),
          );
        }
        return Container();
      },
    );
  }
}
