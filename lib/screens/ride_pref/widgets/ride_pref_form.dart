import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../utils/date_time_util.dart';
import '../../../widgets/button/bla_button.dart';
import '../../../theme/theme.dart';
import '../location_picker/location_picker_screen.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;
  final Function(RidePref)? onSearch;

  const RidePrefForm({super.key, this.initRidePref, this.onSearch});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  Location? arrival;
  late DateTime departureDate;
  late int requestedSeats;

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  bool get isValid =>
      departure != null &&
      arrival != null &&
      departure != arrival &&
      requestedSeats > 0;

  void switchLocations() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  void handleSearch() {
    if (!isValid) return;

    final ridePref = RidePref(
      departure: departure!,
      arrival: arrival!,
      departureDate: departureDate,
      requestedSeats: requestedSeats,
    );

    widget.onSearch?.call(ridePref);
  }

  Future<void> pickLocation(bool isDeparture) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LocationPickerScreen()),
    );

    if (result != null && result is Location) {
      setState(() {
        if (isDeparture) {
          departure = result;
        } else {
          arrival = result;
        }
      });
    }
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      setState(() => departureDate = picked);
    }
  }

  void changeSeats() {
    setState(() => requestedSeats = requestedSeats % 4 + 1);
  }

  Widget buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BlaSpacings.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildListTile(
            icon: Icons.location_on,
            title: departure?.name ?? "Leaving from",
            trailing: IconButton(
              icon: const Icon(Icons.swap_vert),
              onPressed: switchLocations,
            ),
            onTap: () => pickLocation(true),
          ),
          const Divider(),
          buildListTile(
            icon: Icons.location_on,
            title: arrival?.name ?? "Going to",
            onTap: () => pickLocation(false),
          ),
          const Divider(),
          buildListTile(
            icon: Icons.calendar_today,
            title: DateTimeUtils.formatDateTime(departureDate),
            onTap: pickDate,
          ),
          const Divider(),
          buildListTile(
            icon: Icons.event_seat,
            title: "$requestedSeats passenger${requestedSeats > 1 ? "s" : ""}",
            onTap: changeSeats,
          ),
          const SizedBox(height: BlaSpacings.l),
          BlaButton(
            label: "Search",
            variant: ButtonVariant.primary,
            onPressed: isValid ? handleSearch : null,
          ),
        ],
      ),
    );
  }
}
