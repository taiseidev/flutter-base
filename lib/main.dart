import 'package:flutter/material.dart';
import 'package:flutter_base/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'timezone_pub/app.dart';

const flavor = String.fromEnvironment('FLAVOR');

void main() {
  // タイムゾーンデータベースを初期化
  tz.initializeTimeZones();
  initializeDateFormatting();
  runApp(
    ProviderScope(
      overrides: _setUp(),
      child: Consumer(builder: (context, ref, child) {
        return ref.read(appProvider);
      }),
    ),
  );
}

List<Override> _setUp() => () {
      if (flavor == 'timezone-pub') {
        return <Override>[appProvider.overrideWithValue(const MyApp())];
      }
      return <Override>[];
    }();
