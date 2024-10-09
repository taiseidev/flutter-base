import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_start_app_service.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartupService(AppStartupServiceRef ref) async {
  ref.onDispose(() {});

  await Future.delayed(const Duration(seconds: 3));
}
