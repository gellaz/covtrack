import 'package:bloc/bloc.dart';

/// With this helper class we have access to all BLoCs Transitions in
/// one place and we can do something in response to all of them.
/// It is mainly used for debugging purposes.
class SimpleBlocDelegate extends BlocDelegate {
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
