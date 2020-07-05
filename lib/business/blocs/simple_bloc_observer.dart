import 'package:bloc/bloc.dart';

/// Helper class through which we have access to all BLoCs Transitions in
/// one place and we can do something in response to all of them.
/// In this case is used as a logger printing on screen all BLoCs events,
/// transitions and errors.
class SimpleBlocObserver extends BlocObserver {
  /// Prints the event when it is added to the BLoC.
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  /// Prints the error message when an Exception is thrown in a BLoC.
  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  /// Prints the transition from one state to another in a BLoC.
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}
