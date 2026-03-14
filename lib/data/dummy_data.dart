import '../model/ride/locations.dart';
import '../model/ride/ride.dart';
import '../model/ride_pref/ride_pref.dart';
import '../model/user/user.dart';
import 'dart:math';

final Random random = Random();

///
/// FACE DATA FOR TEST PURPOSE
///

// Fake Cities
const List<Location> fakeLocations = [
  // UK Cities
  Location(name: "London", country: Country.uk),
  Location(name: "Manchester", country: Country.uk),
  Location(name: "Birmingham", country: Country.uk),
  Location(name: "Liverpool", country: Country.uk),
  Location(name: "Leeds", country: Country.uk),
  Location(name: "Glasgow", country: Country.uk),
  Location(name: "Sheffield", country: Country.uk),
  Location(name: "Bristol", country: Country.uk),
  Location(name: "Edinburgh", country: Country.uk),
  Location(name: "Leicester", country: Country.uk),
  Location(name: "Coventry", country: Country.uk),
  Location(name: "Nottingham", country: Country.uk),
  Location(name: "Newcastle", country: Country.uk),
  Location(name: "Southampton", country: Country.uk),
  Location(name: "Portsmouth", country: Country.uk),
  Location(name: "Aberdeen", country: Country.uk),
  Location(name: "Swansea", country: Country.uk),
  Location(name: "Oxford", country: Country.uk),
  Location(name: "Cambridge", country: Country.uk),

  // France Cities
  Location(name: "Paris", country: Country.france),
  Location(name: "Lyon", country: Country.france),
  Location(name: "Marseille", country: Country.france),
  Location(name: "Toulouse", country: Country.france),
  Location(name: "Nice", country: Country.france),
  Location(name: "Nantes", country: Country.france),
  Location(name: "Strasbourg", country: Country.france),
  Location(name: "Montpellier", country: Country.france),
  Location(name: "Bordeaux", country: Country.france),
  Location(name: "Lille", country: Country.france),
  Location(name: "Rennes", country: Country.france),
  Location(name: "Reims", country: Country.france),
  Location(name: "Saint-Étienne", country: Country.france),
  Location(name: "Toulon", country: Country.france),
  Location(name: "Angers", country: Country.france),
  Location(name: "Grenoble", country: Country.france),
  Location(name: "Dijon", country: Country.france),
  Location(name: "Le Havre", country: Country.france),
  Location(name: "Brest", country: Country.france),
];

// Fake Ride Preferences
List<RidePreference> fakeRidePrefs = [
  RidePreference(
    departure: fakeLocations[0], // London
    departureDate: DateTime.now().add(Duration(days: 1)), // Tomorrow
    arrival: fakeLocations[3], // Paris
    requestedSeats: 2,
  ),
  RidePreference(
    departure: fakeLocations[1], // Manchester
    departureDate: DateTime.now().add(Duration(days: 7)), // Next week
    arrival: fakeLocations[4], // Lyon
    requestedSeats: 3,
  ),
  RidePreference(
    departure: fakeLocations[2], // Birmingham
    departureDate: DateTime.now(), // Today
    arrival: fakeLocations[5], // Marseille
    requestedSeats: 1,
  ),
  RidePreference(
    departure: fakeLocations[0], // London
    departureDate: DateTime.now().add(Duration(days: 1)), // Tomorrow
    arrival: fakeLocations[3], // Paris
    requestedSeats: 2,
  ),
  RidePreference(
    departure: fakeLocations[4], // Manchester
    departureDate: DateTime.now().add(Duration(days: 7)), // Next week
    arrival: fakeLocations[0], // Lyon
    requestedSeats: 3,
  ),
  RidePreference(
    departure: fakeLocations[5], // Birmingham
    departureDate: DateTime.now(), // Today
    arrival: fakeLocations[1], // Marseille
    requestedSeats: 1,
  ),
];

// Fake  Users
List<User> fakeUsers = [
  User(
    firstName: "Alice",
    lastName: "Dupont",
    email: "alice.dupont@example.com",
    phone: "+33 612345678",
    profilePicture: "https://randomuser.me/api/portraits/women/1.jpg",
    verifiedProfile: true,
  ),
  User(
    firstName: "Bob",
    lastName: "Smith",
    email: "bob.smith@example.com",
    phone: "+44 789456123",
    profilePicture: "https://randomuser.me/api/portraits/men/2.jpg",
    verifiedProfile: false,
  ),
  User(
    firstName: "Charlie",
    lastName: "Martin",
    email: "charlie.martin@example.com",
    phone: "+33 674839201",
    profilePicture: "https://randomuser.me/api/portraits/men/3.jpg",
    verifiedProfile: true,
  ),
  User(
    firstName: "Diane",
    lastName: "Lemoine",
    email: "diane.lemoine@example.com",
    phone: "+44 741258963",
    profilePicture: "https://randomuser.me/api/portraits/women/4.jpg",
    verifiedProfile: true,
  ),
  User(
    firstName: "Ethan",
    lastName: "Brown",
    email: "ethan.brown@example.com",
    phone: "+44 785412369",
    profilePicture: "https://randomuser.me/api/portraits/men/5.jpg",
    verifiedProfile: false,
  ),
  User(
    firstName: "Fanny",
    lastName: "Durand",
    email: "fanny.durand@example.com",
    phone: "+33 675839201",
    profilePicture: "https://randomuser.me/api/portraits/women/6.jpg",
    verifiedProfile: true,
  ),
];


// Fake  Rides
 List<Ride> fakeRides = [
  Ride(
    departureLocation: fakeLocations[0], // London
    departureDate: DateTime.now().add(Duration(hours: 3)),
    arrivalLocation: fakeLocations[19], // Paris
    arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
    driver: fakeUsers[0],
    availableSeats: 2,
    pricePerSeat: 25.0,
  ),

  Ride(
    departureLocation: fakeLocations[0], // London
    departureDate: DateTime.now().add(Duration(hours: 10)),
    arrivalLocation: fakeLocations[19], // Paris
    arrivalDateTime: DateTime.now().add(Duration(hours: 9)),
    driver: fakeUsers[1],
    availableSeats: 1,
    pricePerSeat: 30.0,
  ),

  Ride(
    departureLocation: fakeLocations[2], // Birmingham
    departureDate: DateTime.now().add(Duration(days: 1)),
    arrivalLocation: fakeLocations[22], // Toulouse
    arrivalDateTime: DateTime.now().add(Duration(days: 1, hours: 4)),
    driver: fakeUsers[2],
    availableSeats: 2,
    pricePerSeat: 22.5,
  ),

  Ride(
    departureLocation: fakeLocations[3], // Liverpool
    departureDate: DateTime.now().add(Duration(days: 2)),
    arrivalLocation: fakeLocations[23], // Nice
    arrivalDateTime: DateTime.now().add(Duration(days: 2, hours: 6)),
    driver: fakeUsers[3],
    availableSeats: 3,
    pricePerSeat: 35.0,
  ),

  Ride(
    departureLocation: fakeLocations[4], // Leeds
    departureDate: DateTime.now().add(Duration(days: 2, hours: 5)),
    arrivalLocation: fakeLocations[24], // Nantes
    arrivalDateTime: DateTime.now().add(Duration(days: 2, hours: 10)),
    driver: fakeUsers[4],
    availableSeats: 4,
    pricePerSeat: 28.0,
  ),

  Ride(
    departureLocation: fakeLocations[5], // Glasgow
    departureDate: DateTime.now().add(Duration(days: 3)),
    arrivalLocation: fakeLocations[25], // Strasbourg
    arrivalDateTime: DateTime.now().add(Duration(days: 3, hours: 7)),
    driver: fakeUsers[5],
    availableSeats: 3,
    pricePerSeat: 40.0,
  ),

  Ride(
    departureLocation: fakeLocations[6], // Sheffield
    departureDate: DateTime.now().add(Duration(days: 3, hours: 2)),
    arrivalLocation: fakeLocations[26], // Montpellier
    arrivalDateTime: DateTime.now().add(Duration(days: 3, hours: 8)),
    driver: fakeUsers[0],
    availableSeats: 2,
    pricePerSeat: 26.0,
  ),

  Ride(
    departureLocation: fakeLocations[7], // Bristol
    departureDate: DateTime.now().add(Duration(days: 4)),
    arrivalLocation: fakeLocations[27], // Bordeaux
    arrivalDateTime: DateTime.now().add(Duration(days: 4, hours: 6)),
    driver: fakeUsers[1],
    availableSeats: 3,
    pricePerSeat: 29.0,
  ),

  Ride(
    departureLocation: fakeLocations[8], // Edinburgh
    departureDate: DateTime.now().add(Duration(days: 4, hours: 4)),
    arrivalLocation: fakeLocations[28], // Lille
    arrivalDateTime: DateTime.now().add(Duration(days: 4, hours: 9)),
    driver: fakeUsers[2],
    availableSeats: 4,
    pricePerSeat: 27.5,
  ),

  Ride(
    departureLocation: fakeLocations[9], // Leicester
    departureDate: DateTime.now().add(Duration(days: 5)),
    arrivalLocation: fakeLocations[29], // Rennes
    arrivalDateTime: DateTime.now().add(Duration(days: 5, hours: 5)),
    driver: fakeUsers[3],
    availableSeats: 3,
    pricePerSeat: 24.0,
  ),

  // Continue the same pattern until 50 rides
];
