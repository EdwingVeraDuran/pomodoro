import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/bloc/timer_bloc.dart';
import 'package:pomodoro/bloc/timer_event.dart';
import 'package:pomodoro/widgets/action_button.dart';

class ActionsRow extends StatelessWidget {
  final bool isRunning;
  const ActionsRow({super.key, required this.isRunning});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 32,
      children: [
        ActionButton(
          icon: Icons.replay,
          isActive: !isRunning,
          onPressed: () => context.read<TimerBloc>().add(ResetTimer()),
        ),
        ActionButton(
          icon: isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
          onPressed: () => context.read<TimerBloc>().add(StartPauseTimer()),
        ),
      ],
    );
  }
}
