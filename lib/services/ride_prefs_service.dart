import '../model/ride_pref/ride_pref.dart';

////
///   This service handles:
///   - History of the last ride preferences        (to allow users to re-use their last preferences)
///   - Curent selected ride preferences.
///

// TODO Improve this with a proper repository and a global state
class RidePrefsService {
  static RidePreference? _selectedPreference;
  static final List<RidePreference> _preferenceHistory = [];

  static final int maxAllowedSeats = 8;

  static RidePreference? get selectedPreference => _selectedPreference;
  static List<RidePreference> get preferenceHistory => _preferenceHistory;

  static void selectPreference(RidePreference preference) {
    if (preference != _selectedPreference) {
      // Set the selected preference
      _selectedPreference = preference;

      // Push to history
      _addPreferenceToHistory(preference);
    }
  }

  static void _addPreferenceToHistory(RidePreference preference) {
    _preferenceHistory.add(preference);
  }
}
