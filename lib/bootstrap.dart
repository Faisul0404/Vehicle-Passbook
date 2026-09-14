import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/config/app_environment.dart';

GetIt get getIt => GetIt.instance;

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required AppEnvironment environment,
}) async {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: environment.envFile);
  await Hive.initFlutter();
  await setup(environment);

  runApp(await builder());
  WidgetsBinding.instance.addPostFrameCallback((_) {
    FlutterNativeSplash.remove();
  });
}

Future<void> setup(AppEnvironment environment) async {
  getIt.registerSingleton<AppConfig>(AppConfig.fromEnvironment(environment));
  await getIt.allReady();
}
