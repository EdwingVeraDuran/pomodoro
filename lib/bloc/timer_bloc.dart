import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/bloc/timer_event.dart';
import 'package:pomodoro/bloc/timer_mode.dart';
import 'package:pomodoro/bloc/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
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

  void _onTick(Tick event, Emitter<TimerState> emit) async {
    final newTime = state.remainingSeconds - 1;

    if (newTime <= 0) {
      _timer?.cancel();

      await _audioPlayer.play(
        AssetSource('sounds/notification.mp3'),
        volume: .3,
      );

      emit(TimerState(remainingSeconds: 0, isRunning: false, mode: state.mode));

      add(ResetTimer());
    } else {
      emit(
        TimerState(
          remainingSeconds: newTime,
          isRunning: true,
          mode: state.mode,
        ),
      );
    }
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
