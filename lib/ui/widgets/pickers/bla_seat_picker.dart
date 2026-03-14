import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../buttons/bla_circle_button.dart';
import '../buttons/bla_icon_button.dart';

class BlaSeatPicker extends StatefulWidget {
  const BlaSeatPicker({super.key, this.initSeats, required this.maxSeat});

  final int? initSeats;
  final int maxSeat;

  @override
  State<BlaSeatPicker> createState() => _BlaSeatPickerState();
}

class _BlaSeatPickerState extends State<BlaSeatPicker> {
  late int selectedSeat;

  void onSubmit() {
    Navigator.pop<int>(context, selectedSeat);
  }

  void onBackTap() {
    Navigator.pop(context);
  }

  void onMinus() {
    if (selectedSeat >1) {
      setState(() => selectedSeat--);
    }
  }

  void onPlus() {
    if (selectedSeat < widget.maxSeat) {
      setState(() => selectedSeat++);
    }
  }

  bool get minusDisabled => selectedSeat == 1;
  bool get plusDisabled => selectedSeat >= widget.maxSeat;

  @override
  void initState() {
    super.initState();
    selectedSeat = widget.initSeats ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(BlaSpacings.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back icon
            BlaIconButton(onPressed: onBackTap, icon: Icons.close),
            SizedBox(height: BlaSpacings.m),

            // Title
            Text(
              "Number of seats to book",
              style: BlaTextStyles.title.copyWith(color: BlaColors.textNormal),
            ),

            // Form
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlaCircleButton(
                  icon: Icons.remove,
                  type: CircleButtonType.secondary,
                  disabled: minusDisabled,
                  onPressed: onMinus,
                ),
                Text(
                  "$selectedSeat",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                    color: BlaColors.textNormal,
                  ),
                ),
                BlaCircleButton(
                  icon: Icons.add,
                  type: CircleButtonType.secondary,
                   disabled: plusDisabled,
                  onPressed: onPlus,
                ),
              ],
            ),

            Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlaCircleButton(icon: Icons.arrow_forward, onPressed: onSubmit),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
