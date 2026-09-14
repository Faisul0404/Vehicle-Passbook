import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppEnvironment {
  development,
  staging,
  production;

  String get envFile => 'env/.env.$name';
}

final class AppConfig {
  AppConfig._({
    required this.environment,
    required this.baseUrl,
    required this.apiKey,
    required this.sessionKey,
    required this.googlePlacesApiKey,
  });

  factory AppConfig.fromEnvironment(AppEnvironment environment) => AppConfig._(
    environment: environment,
    baseUrl: dotenv.get('BASE_URL'),
    apiKey: dotenv.get('API_KEY'),
    sessionKey: dotenv.get('SESSION_KEY'),
    googlePlacesApiKey: dotenv.get('GOOGLE_PLACES_API_KEY'),
  );

  final AppEnvironment environment;
  final String baseUrl;
  final String apiKey;
  final String sessionKey;
  final String googlePlacesApiKey;
}
