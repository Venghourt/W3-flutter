import 'package:flutter/material.dart';

import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../utils/date_time_utils.dart';
import '../../../theme/theme.dart';
import '../../../widgets/buttons/bla_text_button.dart';

///
///  The Ride selection header combines the ride preference summary  + the navigation back button + filter button
///
class RideSelectionHeader extends StatelessWidget {
  const RideSelectionHeader({
    super.key,
    required this.ridePreference,
    required this.onBackPressed,
    required this.onPreferencePressed,
    required this.onFilterPressed,
  });

  final RidePreference ridePreference;

  final VoidCallback onBackPressed;
  final VoidCallback onPreferencePressed;
  final VoidCallback onFilterPressed;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius:
            BorderRadius.circular(BlaSpacings.radius), // Rounded corners
      ),
      child: Row(
        children: [
          // 1 - Left icon
          IconButton(
            onPressed: onBackPressed,
            icon: Icon(
              Icons.arrow_back_ios,
              color: BlaColors.iconLight,
              size: 16,
            ),
          ),

          // 2 - Ride Summary
          Expanded(
            child: RidePreferenceSummary(
              ridePref: ridePreference,
              onPressed: onPreferencePressed,
            ),
          ),

          // 3 - Filter button
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BlaTextButton(text: "Filter", onPressed: onFilterPressed),
          )
        ],
      ),
    );
  }
}

class RidePreferenceSummary extends StatelessWidget {
  final RidePreference ridePref;
  final VoidCallback onPressed;
  const RidePreferenceSummary({
    super.key,
    required this.ridePref,
    required this.onPressed,
  });

  String get title => "${ridePref.departure.name} → ${ridePref.arrival.name}";

  String get subTitle =>
      "${DateTimeUtils.formatDateTime(ridePref.departureDate)}, ${ridePref.requestedSeats} passenger${ridePref.requestedSeats > 1 ? "s" : ""}";

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal),
            ),
            Text(
              subTitle,
              style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
            ),
          ],
        ),
      ),
    );
  }
}
