part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class CreateDisplacement extends HomeEvent {
  final Displacement displacement;

  const CreateDisplacement(this.displacement);

  @override
  List<Object> get props => [displacement];
}
