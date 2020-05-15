import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/houses/houses_bloc.dart';
import '../choose_first_house_screen.dart';
import '../error_screen.dart';
import '../root/root_screen.dart';
import '../splash_screen.dart';

class HousesWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HousesBloc, HousesState>(
      bloc: BlocProvider.of<HousesBloc>(context)..add(LoggedIn()),
      builder: (context, state) {
        if (state is HousesLoadInProgress) {
          return SplashScreen();
        }
        if (state is HousesLoadSuccess) {
          if (state.houses.isEmpty)
            return ChooseFirstHouseScreen();
          else
            return RootScreen();
        }
        if (state is HousesLoadFailure) {
          return ErrorScreen();
        }
        return SplashScreen();
      },
    );
  }
}
