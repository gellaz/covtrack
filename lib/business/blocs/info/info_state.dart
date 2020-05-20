part of 'info_bloc.dart';

abstract class InfoState extends Equatable {
  const InfoState();
}

class InfoInitial extends InfoState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'InfoInitial';
}

class InfoLoadInProgress extends InfoState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'InfoLoadInProgress';
}

class InfoLoadSuccess extends InfoState {
  final Info localInfo;
  final Info globalInfo;

  const InfoLoadSuccess(this.localInfo, this.globalInfo);

  @override
  List<Object> get props => [localInfo, globalInfo];

  @override
  String toString() =>
      'InfoLoadSuccess {localInfo: $localInfo, globalInfo: $globalInfo}';
}

class InfoLoadFailure extends InfoState {
  final String message;

  const InfoLoadFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'InfoLoadFailure {message: $message}';
}
