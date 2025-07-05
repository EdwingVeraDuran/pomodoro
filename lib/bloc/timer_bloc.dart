import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/bloc/timer_event.dart';
import 'package:pomodoro/bloc/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _initialTime = 25 * 60;
  Timer? _timer;

  TimerBloc() : super(TimerState.initial()) {
    on<StartPauseTimer>(_onStartPause);
    on<ResetTimer>(_onReset);
    on<Tick>(_onTick);
  }

  void _onStartPause(StartPauseTimer event, Emitter<TimerState> emit) {
    if (state.isRunning) {
      _timer?.cancel();
      emit(
        TimerState(remainingSeconds: state.remainingSeconds, isRunning: false),
      );
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (state.remainingSeconds > 0) {
          add(Tick());
        } else {
          timer.cancel();
        }
      });
      emit(
        TimerState(remainingSeconds: state.remainingSeconds, isRunning: true),
      );
    }
  }

  void _onReset(ResetTimer event, Emitter<TimerState> emit) {
    _timer?.cancel();
    emit(TimerState(remainingSeconds: _initialTime, isRunning: false));
  }

  void _onTick(Tick event, Emitter<TimerState> emit) {
    emit(
      TimerState(remainingSeconds: state.remainingSeconds - 1, isRunning: true),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
