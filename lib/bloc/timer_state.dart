import 'package:intl/intl.dart';
import 'package:pomodoro/bloc/timer_mode.dart';

class TimerState {
  final int remainingSeconds;
  final bool isRunning;
  final TimerMode mode;

  TimerState({
    required this.remainingSeconds,
    required this.isRunning,
    required this.mode,
  });

  factory TimerState.initial() {
    return TimerState(
      remainingSeconds: 25 * 60,
      isRunning: false,
      mode: TimerMode.pomodoro,
    );
  }

  String get formattedTime {
    final duration = Duration(seconds: remainingSeconds);
    final date = DateTime(0).add(duration);
    final formatter = DateFormat('mm:ss');
    return formatter.format(date);
  }

  double get progress => 1 - (remainingSeconds / mode.duration);
}
