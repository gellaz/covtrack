part of 'stopwatch_bloc.dart';

abstract class StopwatchEvent extends Equatable {
  const StopwatchEvent();
  @override
  List<Object> get props => [];
}

class Start extends StopwatchEvent {}

class Tick extends StopwatchEvent {}

class Stop extends StopwatchEvent {}

class Reset extends StopwatchEvent {}
