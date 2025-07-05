enum TimerMode { pomodoro, shortBreak, longBreak }

extension TimerModeExtension on TimerMode {
  int get duration {
    switch (this) {
      case TimerMode.pomodoro:
        return 25 * 60;
      case TimerMode.shortBreak:
        return 5 * 60;
      case TimerMode.longBreak:
        return 15 * 60;
    }
  }

  String get label {
    switch (this) {
      case TimerMode.pomodoro:
        return 'Pomodoro';
      case TimerMode.shortBreak:
        return 'Descanso corto';
      case TimerMode.longBreak:
        return 'Descanso largo';
    }
  }
}
