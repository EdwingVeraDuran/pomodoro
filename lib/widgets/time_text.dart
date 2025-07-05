import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TimeText extends StatelessWidget {
  final String time;
  final double percent;
  const TimeText({super.key, required this.time, required this.percent});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 120,
      lineWidth: 12,
      percent: percent,
      progressColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.primaryForeground,
      center: Text(time).x5Large.bold,
    );
  }
}
