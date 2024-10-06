import 'package:flutter/material.dart';
import 'package:flutter_base_i18n/gen/strings.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // デバイスのロケールで初期化
  LocaleSettings.useDeviceLocale();

  runApp(
    TranslationProvider(
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final greeting = t.greeting;
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: Scaffold(
        body: Center(
          child: Text(greeting),
        ),
      ),
    );
  }
}
