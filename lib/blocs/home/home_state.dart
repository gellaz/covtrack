part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class NoCurrentDispacement extends HomeState {
  @override
  List<Object> get props => [];
}

class CurrentDisplacement extends HomeState {
  final Displacement displacement;

  const CurrentDisplacement(this.displacement);

  @override
  List<Object> get props => [displacement];
}
