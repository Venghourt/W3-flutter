import 'package:flutter/material.dart';
import 'package:blabla/theme/theme.dart';

enum ButtonVariant { primary, secondary }

class BlaButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final ButtonVariant variant;
  final VoidCallback? onPressed;

  const BlaButton({
    super.key,
    required this.label,
    required this.variant,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = variant == ButtonVariant.primary;
    final backgroundColor = isPrimary
        ? BlaColors.backGroundColor
        : BlaColors.backgroundAccent;
    final contentColor = isPrimary ? BlaColors.white : BlaColors.primary;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
        ),
        minimumSize: const Size.fromHeight(48),
      ),
      child: icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: contentColor),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: BlaTextStyles.label.copyWith(color: contentColor),
                ),
              ],
            )
          : Text(
              label,
              style: BlaTextStyles.label.copyWith(color: contentColor),
            ),
    );
  }
}
