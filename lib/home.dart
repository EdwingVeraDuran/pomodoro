import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/bloc/timer_bloc.dart';
import 'package:pomodoro/bloc/timer_state.dart';
import 'package:pomodoro/widgets/actions_row.dart';
import 'package:pomodoro/widgets/mode_selector.dart';
import 'package:pomodoro/widgets/time_text.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Center(
        child: BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 32,
              children: [
                ModeSelector(value: state.mode, enabled: !state.isRunning),
                TimeText(time: state.formattedTime, percent: state.progress),
                ActionsRow(isRunning: state.isRunning),
              ],
            );
          },
        ),
      ),
    );
  }
}
