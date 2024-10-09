import 'package:flutter/material.dart';
import 'package:flutter_base_app/features/startup/presentation/app_start_app.dart';
import 'package:flutter_base_i18n/gen/strings.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // デバイスのロケールで初期化
  LocaleSettings.useDeviceLocale();

  runApp(
    ProviderScope(
      child: TranslationProvider(
        child: const AppStartupWidget(),
      ),
    ),
  );
}
