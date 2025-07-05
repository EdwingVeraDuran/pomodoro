import 'package:pomodoro/bloc/timer_mode.dart';

sealed class TimerEvent {}

class ChangeMode extends TimerEvent {
  final TimerMode mode;
  ChangeMode(this.mode);
}

class StartPauseTimer extends TimerEvent {}

class ResetTimer extends TimerEvent {}

class Tick extends TimerEvent {}
