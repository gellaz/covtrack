part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();
}

class InfoFetched extends InfoEvent {
  @override
  List<Object> get props => [];
}
