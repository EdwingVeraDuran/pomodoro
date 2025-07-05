import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/bloc/timer_bloc.dart';
import 'package:pomodoro/home.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  runApp(const PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorSchemes.lightRose(), radius: 1),
      scaling: AdaptiveScaling(1.2),
      home: BlocProvider<TimerBloc>(create: (_) => TimerBloc(), child: Home()),
    );
  }
}
