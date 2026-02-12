import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../../service/locations_service.dart';
import '../../../../theme/theme.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final TextEditingController _controller = TextEditingController();

  List<Location> filteredLocations = LocationsService.availableLocations;

  void _filterLocations(String query) {
    setState(() {
      filteredLocations = LocationsService.availableLocations
          .where(
            (location) =>
                location.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: BlaColors.primary,
        title: const Text("Select location"),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search location",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _controller.clear();
                    _filterLocations('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onChanged: _filterLocations,
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                final location = filteredLocations[index];

                return ListTile(
                  title: Text(location.name),
                  subtitle: Text(location.country.name),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pop(context, location);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
