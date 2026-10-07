import 'package:flutter/material.dart';
import 'package:flutter_app/config/constants/environment.dart';
import 'package:flutter_app/config/router/app_router.dart';
import 'package:flutter_app/config/theme/app_theme.dart';
import 'package:flutter_app/config/theme/provider/theme_provider.dart';
import 'package:flutter_app/features/shared/provider/shared_preference_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Environment.init();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mini Catálogo',
      routerConfig: ref.watch(routerProvider),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      // home: const HomeScreen(),
    );
  }
}
