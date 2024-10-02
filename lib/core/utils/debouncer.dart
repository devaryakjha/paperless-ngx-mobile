import 'dart:async' show Timer;

final class Debouncer {
  Debouncer(this.duration);

  final Duration duration;
  Timer? _timer;

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }
}
