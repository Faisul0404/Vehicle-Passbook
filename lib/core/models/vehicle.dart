class Vehicle {
  const Vehicle({
    required this.id,
    required this.plate,
    required this.brand,
    required this.model,
    required this.year,
    required this.fuelType,
    required this.odometer,
    required this.color,
  });
  final String id, plate, brand, model, fuelType;
  final int year, odometer, color;
}

class PassportEntry {
  const PassportEntry({
    required this.vehicleId,
    required this.title,
    required this.provider,
    required this.date,
    required this.cost,
  });
  final String vehicleId, title, provider, date;
  final int cost;
}

class Reminder {
  const Reminder({required this.title, required this.dueInDays});
  final String title;
  final int dueInDays;
}

class Garage {
  const Garage({
    required this.name,
    required this.location,
    required this.distance,
    required this.rating,
    required this.open,
  });
  final String name, location, distance;
  final double rating;
  final bool open;
}
