import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/bloc/timer_event.dart';
import 'package:pomodoro/bloc/timer_mode.dart';
import 'package:pomodoro/bloc/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;

  TimerBloc() : super(TimerState.initial()) {
    on<StartPauseTimer>(_onStartPause);
    on<ResetTimer>(_onReset);
    on<Tick>(_onTick);
    on<ChangeMode>(_onChangeMode);
  }

  void _onStartPause(StartPauseTimer event, Emitter<TimerState> emit) {
    if (state.isRunning) {
      _timer?.cancel();
      emit(
        TimerState(
          remainingSeconds: state.remainingSeconds,
          isRunning: false,
          mode: state.mode,
        ),
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
        TimerState(
          remainingSeconds: state.remainingSeconds,
          isRunning: true,
          mode: state.mode,
        ),
      );
    }
  }

  void _onReset(ResetTimer event, Emitter<TimerState> emit) {
    _timer?.cancel();
    emit(
      TimerState(
        remainingSeconds: state.mode.duration,
        isRunning: false,
        mode: state.mode,
      ),
    );
  }

  void _onTick(Tick event, Emitter<TimerState> emit) {
    emit(
      TimerState(
        remainingSeconds: state.remainingSeconds - 1,
        isRunning: true,
        mode: state.mode,
      ),
    );
  }

  void _onChangeMode(ChangeMode event, Emitter<TimerState> emit) {
    emit(
      TimerState(
        remainingSeconds: event.mode.duration,
        isRunning: false,
        mode: event.mode,
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
