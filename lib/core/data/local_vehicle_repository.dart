import '../models/vehicle.dart';

class LocalVehicleRepository {
  const LocalVehicleRepository();
  List<Vehicle> get vehicles => const [
    Vehicle(
      id: 'v1',
      plate: 'CAB-7823',
      brand: 'Toyota',
      model: 'Aqua',
      year: 2018,
      fuelType: 'Hybrid',
      odometer: 94500,
      color: 0xFF3B82F6,
    ),
    Vehicle(
      id: 'v2',
      plate: 'WP-GH-4491',
      brand: 'Suzuki',
      model: 'Alto',
      year: 2020,
      fuelType: 'Petrol',
      odometer: 47200,
      color: 0xFFEC4899,
    ),
  ];
  List<PassportEntry> entriesFor(String id) => const [
    PassportEntry(
      vehicleId: 'v1',
      title: 'Full Service',
      provider: 'Toyota Lanka Service Centre',
      date: '15 Aug 2026',
      cost: 18500,
    ),
    PassportEntry(
      vehicleId: 'v1',
      title: 'Tyre Replacement',
      provider: 'Keells Tyres Nugegoda',
      date: '03 May 2026',
      cost: 62000,
    ),
    PassportEntry(
      vehicleId: 'v1',
      title: 'Insurance Renewed',
      provider: 'AIA Insurance',
      date: '20 Jan 2026',
      cost: 45000,
    ),
    PassportEntry(
      vehicleId: 'v2',
      title: 'Minor Service',
      provider: 'Maruti Service Centre Colombo',
      date: '22 Jul 2026',
      cost: 8900,
    ),
  ].where((e) => e.vehicleId == id).toList();
  List<Reminder> get reminders => const [
    Reminder(title: 'Emission Test', dueInDays: 18),
    Reminder(title: 'Next Service Due', dueInDays: 63),
  ];
  List<Garage> get garages => const [
    Garage(
      name: 'Toyota Lanka Service Centre',
      location: 'Peliyagoda, Colombo',
      distance: '3.2 km',
      rating: 4.8,
      open: true,
    ),
    Garage(
      name: 'AutoCare Pro Nugegoda',
      location: 'Nugegoda, Colombo',
      distance: '5.7 km',
      rating: 4.5,
      open: true,
    ),
    Garage(
      name: 'CarCraft Boralesgamuwa',
      location: 'Boralesgamuwa, Colombo',
      distance: '8.1 km',
      rating: 4.3,
      open: false,
    ),
  ];
}
