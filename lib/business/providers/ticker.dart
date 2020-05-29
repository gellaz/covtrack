/// The [Ticker] class will be our data source for the timer.
/// It will expose a [tick] function which returns stream of ticks
/// which we can subscribe and react to.
class Ticker {
  /// Takes the number of ticks (seconds) we want and returns a stream
  /// which emits the remaining seconds every second.
  Stream<int> tick(int ticks) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks + x + 1)
        .take(ticks);
  }
}
