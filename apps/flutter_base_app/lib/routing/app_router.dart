import 'package:flutter/material.dart';
import 'package:flutter_base_app/constants/routing/startup_path.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/routing/auth_path.dart';
import '../features/auth/presentation/top_page.dart';
import '../features/startup/application/app_start_app_service.dart';
import '../features/startup/presentation/app_startup.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final appStartupState = ref.watch(appStartupServiceProvider);

  return GoRouter(
    initialLocation: StartupPath.root,
    debugLogDiagnostics: true,
    routes: $appRoutes,
    redirect: (context, state) {
      if (appStartupState.isLoading || appStartupState.hasError) {
        return StartupPath.root;
      }

      final isAuthCompleted =
          appStartupState.valueOrNull != appStartupState.valueOrNull;

      if (isAuthCompleted) {
        // ここにログイン後の画面を表示する。
      } else {
        return AuthPath.root;
      }
      return null;
    },
  );
}

/// アプリの初期化を行うためのルート。
///
/// 処理内容は下記の通り。
/// - ここに処理内容を記述していく。
@TypedGoRoute<StartupRoute>(
  path: StartupPath.root,
)
class StartupRoute extends GoRouteData {
  const StartupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AppStartupWidget();
}

/// 認証に関連するルート。
@TypedGoRoute<AuthRoute>(
  path: AuthPath.root,
)
class AuthRoute extends GoRouteData {
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const TopPage();
}
