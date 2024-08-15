import 'dart:async';
import 'dart:ui';

class Debouncer {
  static final internal = Debouncer._internal();
  Debouncer._internal();
  Timer? _timer;

  factory Debouncer() => internal;

  void run(VoidCallback action) {
    _timer?.cancel(); // Cancel any pending timers.
    _timer = Timer(const Duration(milliseconds: 400), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
