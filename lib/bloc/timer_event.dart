sealed class TimerEvent {}

class StartPauseTimer extends TimerEvent {}

class ResetTimer extends TimerEvent {}

class Tick extends TimerEvent {}
