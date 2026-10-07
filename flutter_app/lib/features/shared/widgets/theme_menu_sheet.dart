import 'package:flutter/material.dart';
import 'package:flutter_app/config/constants/app_durations.dart';
import 'package:flutter_app/config/theme/provider/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showThemeMenuSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    useSafeArea: true,
    builder: (_) => const ThemeMenuSheet(),
  );
}

class ThemeMenuSheet extends ConsumerWidget {
  const ThemeMenuSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final notifier = ref.read(themeModeProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('Apariencia', style: textTheme.titleLarge)),
              // Acceso rápido: alterna claro/oscuro.
              IconButton.filledTonal(
                tooltip: isDark
                    ? 'Cambiar a modo claro'
                    : 'Cambiar a modo oscuro',
                onPressed: notifier.toggleTheme,
                icon: AnimatedSwitcher(
                  duration: AppDurations.medium,
                  transitionBuilder: (child, animation) => RotationTransition(
                    turns: Tween<double>(
                      begin: 0.75,
                      end: 1,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                  child: Icon(
                    isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    key: ValueKey(isDark),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<ThemeMode>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: Icon(Icons.light_mode_rounded),
                  label: Text('Claro'),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: Icon(Icons.dark_mode_rounded),
                  label: Text('Oscuro'),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: Icon(Icons.brightness_auto_rounded),
                  label: Text('Sistema'),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (selection) {
                switch (selection.first) {
                  case ThemeMode.light:
                    notifier.setLightTheme();
                  case ThemeMode.dark:
                    notifier.setDarkTheme();
                  case ThemeMode.system:
                    notifier.setSystemTheme();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
