import 'package:shadcn_flutter/shadcn_flutter.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isActive;
  const ActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.primary(
      shape: ButtonShape.circle,
      onPressed: onPressed,
      enabled: isActive,
      icon: Icon(icon),
    );
  }
}
