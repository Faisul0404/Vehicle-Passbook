import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../core/data/local_vehicle_repository.dart';
import '../../../core/models/vehicle.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final LocalVehicleRepository _repository = const LocalVehicleRepository();
  int _selectedTab = 0;
  int _selectedVehicle = 0;

  @override
  Widget build(BuildContext context) {
    final vehicle = _repository.vehicles[_selectedVehicle];
    final pages = <Widget>[
      _HomePage(
        vehicle: vehicle,
        vehicles: _repository.vehicles,
        entries: _repository.entriesFor(vehicle.id),
        reminders: _repository.reminders,
        selectedVehicle: _selectedVehicle,
        onVehicleSelected: (value) => setState(() => _selectedVehicle = value),
        onServicesPressed: () => setState(() => _selectedTab = 3),
      ),
      _VehiclesPage(
        vehicles: _repository.vehicles,
        selectedVehicle: _selectedVehicle,
        onVehicleSelected: (value) => setState(() {
          _selectedVehicle = value;
          _selectedTab = 0;
        }),
      ),
      _PassportPage(entries: _repository.entriesFor(vehicle.id)),
      _ServicesPage(garages: _repository.garages),
      const _ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _selectedTab, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (value) => setState(() => _selectedTab = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_car_outlined),
            selectedIcon: Icon(Icons.directions_car),
            label: 'Vehicles',
          ),
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article),
            label: 'Passport',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_outlined),
            selectedIcon: Icon(Icons.build),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({
    required this.vehicle,
    required this.vehicles,
    required this.entries,
    required this.reminders,
    required this.selectedVehicle,
    required this.onVehicleSelected,
    required this.onServicesPressed,
  });
  final Vehicle vehicle;
  final List<Vehicle> vehicles;
  final List<PassportEntry> entries;
  final List<Reminder> reminders;
  final int selectedVehicle;
  final ValueChanged<int> onVehicleSelected;
  final VoidCallback onServicesPressed;

  @override
  Widget build(BuildContext context) => ListView(
    children: [
      _Header(vehicle: vehicle),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle('My Vehicles'),
            for (final item in vehicles.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _VehicleCard(
                  vehicle: item.$2,
                  selected: item.$1 == selectedVehicle,
                  onTap: () => onVehicleSelected(item.$1),
                ),
              ),
            const SizedBox(height: 10),
            const _SectionTitle('Quick Actions'),
            Row(
              children: [
                _QuickAction(
                  icon: Icons.local_gas_station_outlined,
                  label: 'Add Fuel',
                  onTap: () => _showForm(context, 'Add Fuel'),
                ),
                _QuickAction(
                  icon: Icons.payments_outlined,
                  label: 'Expense',
                  onTap: () => _showForm(context, 'Log Expense'),
                ),
                _QuickAction(
                  icon: Icons.build_outlined,
                  label: 'Service',
                  onTap: onServicesPressed,
                ),
                _QuickAction(
                  icon: Icons.request_quote_outlined,
                  label: 'Quote',
                  onTap: onServicesPressed,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const _SectionTitle('Needs Attention'),
            for (final reminder in reminders)
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFF5A623),
                  ),
                  title: Text(reminder.title),
                  subtitle: Text('Due in ${reminder.dueInDays} days'),
                ),
              ),
            const SizedBox(height: 14),
            const _SectionTitle('Recent Activity'),
            for (final entry in entries.take(3))
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppColors.mist,
                  child: Icon(Icons.build_outlined, color: AppColors.navy),
                ),
                title: Text(entry.title),
                subtitle: Text(entry.provider),
                trailing: Text(
                  'LKR ${entry.cost}',
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

class _Header extends StatelessWidget {
  const _Header({required this.vehicle});
  final Vehicle vehicle;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [AppColors.navy, Color(0xFF27477E)]),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Good morning,', style: TextStyle(color: Color(0xFFB8C5E2))),
        const Text(
          'Kasun',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            _HeaderStat(label: 'MONTHLY FUEL', value: 'LKR 39.8k'),
            const SizedBox(width: 10),
            _HeaderStat(label: 'ODOMETER', value: '${vehicle.odometer} km'),
          ],
        ),
      ],
    ),
  );
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.ink,
      ),
    ),
  );
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Padding(
      padding: const EdgeInsets.only(right: 6),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 82,
          decoration: BoxDecoration(
            color: AppColors.mist,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.navy),
              const SizedBox(height: 5),
              Text(
                label,
                style: const TextStyle(fontSize: 10, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({
    required this.vehicle,
    required this.selected,
    required this.onTap,
  });
  final Vehicle vehicle;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.mist,
        border: Border.all(
          color: selected ? AppColors.navy : const Color(0x1A1B3A6B),
          width: selected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(vehicle.color).withValues(alpha: .18),
            child: Icon(Icons.directions_car, color: Color(vehicle.color)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${vehicle.brand} ${vehicle.model}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            vehicle.plate,
            style: const TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

class _VehiclesPage extends StatelessWidget {
  const _VehiclesPage({
    required this.vehicles,
    required this.selectedVehicle,
    required this.onVehicleSelected,
  });
  final List<Vehicle> vehicles;
  final int selectedVehicle;
  final ValueChanged<int> onVehicleSelected;
  @override
  Widget build(BuildContext context) => _Page(
    title: 'My Vehicles',
    subtitle: 'Manage your vehicle collection',
    children: [
      for (final item in vehicles.indexed)
        Card(
          child: ListTile(
            onTap: () => onVehicleSelected(item.$1),
            leading: const Icon(Icons.directions_car, color: AppColors.navy),
            title: Text('${item.$2.brand} ${item.$2.model}'),
            subtitle: Text(item.$2.plate),
            trailing: item.$1 == selectedVehicle
                ? const Icon(Icons.check_circle, color: AppColors.navy)
                : null,
          ),
        ),
      OutlinedButton.icon(
        onPressed: () => _message(context, 'Vehicle added to your garage'),
        icon: const Icon(Icons.add),
        label: const Text('Add Vehicle'),
      ),
    ],
  );
}

class _PassportPage extends StatelessWidget {
  const _PassportPage({required this.entries});
  final List<PassportEntry> entries;
  @override
  Widget build(BuildContext context) => _Page(
    title: 'Digital Passport',
    subtitle: 'Service history and expenses',
    children: [
      for (final entry in entries)
        Card(
          child: ListTile(
            leading: const Icon(Icons.build_outlined, color: AppColors.navy),
            title: Text(entry.title),
            subtitle: Text('${entry.provider}\n${entry.date}'),
            isThreeLine: true,
            trailing: Text(
              'LKR ${entry.cost}',
              style: const TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      const Card(
        child: ListTile(
          leading: Icon(Icons.warning_amber_rounded),
          title: Text('Emission Test'),
          subtitle: Text('Due in 18 days'),
        ),
      ),
    ],
  );
}

class _ServicesPage extends StatelessWidget {
  const _ServicesPage({required this.garages});
  final List<Garage> garages;
  @override
  Widget build(BuildContext context) => _Page(
    title: 'Services',
    subtitle: 'Find and book nearby garages',
    children: [
      TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search garages',
          filled: true,
          fillColor: AppColors.mist,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      const SizedBox(height: 14),
      for (final garage in garages)
        Card(
          child: ListTile(
            onTap: () => _showForm(context, 'Book ${garage.name}'),
            title: Text(garage.name),
            subtitle: Text('${garage.location} . ${garage.distance}'),
            trailing: Text(
              '${garage.rating} star\n${garage.open ? 'Open' : 'Closed'}',
              textAlign: TextAlign.right,
              style: TextStyle(color: garage.open ? Colors.green : Colors.red),
            ),
          ),
        ),
    ],
  );
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) => _Page(
    title: 'Profile',
    subtitle: 'Your account and preferences',
    children: const [
      Center(
        child: CircleAvatar(
          radius: 36,
          backgroundColor: AppColors.navy,
          child: Text(
            'KP',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
      SizedBox(height: 12),
      Center(
        child: Text(
          'Kasun Perera',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      Center(
        child: Text(
          'kasun.perera@gmail.com',
          style: TextStyle(color: AppColors.muted),
        ),
      ),
      SizedBox(height: 18),
      Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.workspace_premium_outlined),
              title: Text('Premium Plan'),
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text('Settings'),
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('Help & Support'),
            ),
          ],
        ),
      ),
    ],
  );
}

class _Page extends StatelessWidget {
  const _Page({
    required this.title,
    required this.subtitle,
    required this.children,
  });
  final String title;
  final String subtitle;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      _PageTitle(title: title, subtitle: subtitle),
      ...children,
    ],
  );
}

class _PageTitle extends StatelessWidget {
  const _PageTitle({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'serif',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.ink,
          ),
        ),
        Text(subtitle, style: const TextStyle(color: AppColors.muted)),
      ],
    ),
  );
}

void _showForm(BuildContext context, String title) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (_) => Padding(
    padding: EdgeInsets.fromLTRB(
      20,
      24,
      20,
      MediaQuery.of(context).viewInsets.bottom + 24,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        const TextField(decoration: InputDecoration(labelText: 'Amount (LKR)')),
        const TextField(
          decoration: InputDecoration(labelText: 'Odometer (km)'),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            _message(context, 'Entry saved');
          },
          child: const Text('Save'),
        ),
      ],
    ),
  ),
);
void _message(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
