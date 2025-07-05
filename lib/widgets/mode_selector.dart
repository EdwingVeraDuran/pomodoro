import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/bloc/timer_bloc.dart';
import 'package:pomodoro/bloc/timer_event.dart';
import 'package:pomodoro/bloc/timer_mode.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ModeSelector extends StatelessWidget {
  final TimerMode value;
  final bool enabled;
  ModeSelector({super.key, required this.value, required this.enabled});

  final modes = {
    'Pomodoro': TimerMode.pomodoro,
    'Descanso corto': TimerMode.shortBreak,
    'Descanso largo': TimerMode.longBreak,
  };

  @override
  Widget build(BuildContext context) {
    return Select<TimerMode>(
      value: value,
      enabled: enabled,
      popup: (context) {
        return SelectPopup(
          items: SelectItemList(
            children:
                TimerMode.values
                    .map(
                      (e) => SelectItemButton(value: e, child: Text(e.label)),
                    )
                    .toList(),
          ),
        );
      },
      itemBuilder: (context, value) {
        return Text(value.label, textAlign: TextAlign.center);
      },
      onChanged: (value) {
        context.read<TimerBloc>().add(ChangeMode(value!));
      },
      constraints: BoxConstraints(minWidth: 200),
    );
  }
}
