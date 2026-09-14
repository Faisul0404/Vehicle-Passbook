import 'app/app.dart';
import 'utils/config/app_environment.dart';
import 'bootstrap.dart';

Future<void> main() => bootstrap(
  () => const VehiclePassportApp(),
  environment: AppEnvironment.staging,
);
