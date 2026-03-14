import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum CircleButtonType { primary, secondary }

///
/// Circular icon button used across the application
///
class BlaCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final CircleButtonType type;
  final double size;
  final bool disabled;

  const BlaCircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.type = CircleButtonType.primary,
    this.size = 48,
    this.disabled = false,
  });

  Color get backgroundColor =>
      type == CircleButtonType.primary ? BlaColors.primary : Colors.transparent;

  Color get contentColor => disabled ? BlaColors.greyLight : BlaColors.primary;

  BorderSide get border => type == CircleButtonType.primary
      ? BorderSide.none
      : BorderSide(color: contentColor, width: 2);

  Color get iconColor =>
      type == CircleButtonType.primary ? BlaColors.white : contentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
          shape: const CircleBorder(),
          side: border,
        ),
        onPressed: onPressed,
        child: Icon(icon, color: iconColor, size: 22),
      ),
    );
  }
}
