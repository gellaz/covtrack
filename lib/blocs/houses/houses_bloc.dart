import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/house.dart';
import '../../repositories/houses/houses_repository.dart';

part 'houses_event.dart';
part 'houses_state.dart';

class HousesBloc extends Bloc<HousesEvent, HousesState> {
  final HousesRepository housesRepository;

  HousesBloc(this.housesRepository) : assert(housesRepository != null);

  @override
  HousesState get initialState => HousesInitial();

  @override
  Stream<HousesState> mapEventToState(HousesEvent event) async* {
    if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is HouseAdded) {
      yield* _mapHouseAddedToState(event.house);
    } else if (event is HouseRemoved) {
      yield* _mapHouseRemovedToState(event.house);
    }
  }

  Stream<HousesState> _mapLoggedInToState() async* {
    yield HousesLoadInProgress();
    try {
      final houses = await housesRepository.getHouses();
      yield HousesLoadSuccess(houses: houses);
    } catch (e) {
      yield HousesLoadFailure(e.toString());
    }
  }

  Stream<HousesState> _mapHouseAddedToState(House house) async* {
    yield HousesLoadInProgress();
    try {
      await housesRepository.insert(house);
      yield HousesLoadSuccess();
    } catch (e) {
      yield HousesLoadFailure(e.toString());
    }
  }

  Stream<HousesState> _mapHouseRemovedToState(House house) async* {
    yield HousesLoadInProgress();
    try {
      await housesRepository.delete(house);
      yield HousesLoadSuccess();
    } catch (e) {
      yield HousesLoadFailure(e.toString());
    }
  }
}
