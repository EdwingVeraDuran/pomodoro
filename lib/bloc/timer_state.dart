import 'package:intl/intl.dart';

class TimerState {
  final int remainingSeconds;
  final bool isRunning;

  TimerState({required this.remainingSeconds, required this.isRunning});

  factory TimerState.initial() {
    return TimerState(remainingSeconds: 25 * 60, isRunning: false);
  }

  String get formattedTime {
    final duration = Duration(seconds: remainingSeconds);
    final date = DateTime(0).add(duration);
    final formatter = DateFormat('mm:ss');
    return formatter.format(date);
  }

  double get progress => 1 - (remainingSeconds / (25 * 60));
}
