import 'app/app.dart';
import 'app/config/app_environment.dart';
import 'bootstrap.dart';

Future<void> main() => bootstrap(
  () => const VehiclePassportApp(),
  environment: AppEnvironment.staging,
);
