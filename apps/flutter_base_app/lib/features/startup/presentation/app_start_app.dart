import 'package:flutter/material.dart';
import 'package:flutter_base_i18n/gen/strings.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/app_start_app_service.dart';

final class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupServiceProvider);

    return appStartupState.when(
      loading: () => const _AppStartupLoadingWidget(),
      error: (e, _) => _AppStartupErrorWidget(
        message: e.toString(),
        onRetry: () => ref.invalidate(appStartupServiceProvider),
      ),
      data: (_) => const _MainApp(),
    );
  }
}

final class _MainApp extends ConsumerWidget {
  const _MainApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

// ローディング
final class _AppStartupLoadingWidget extends StatelessWidget {
  const _AppStartupLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

// エラー
final class _AppStartupErrorWidget extends StatelessWidget {
  _AppStartupErrorWidget({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('エラーが発生しました'),
              Text(message),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
