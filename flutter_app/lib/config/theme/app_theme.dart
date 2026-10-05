import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // ============================================================
  // TEMA CLARO
  // ============================================================

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // ------------------------------------------------------------
    // COLORES PRINCIPALES
    // ------------------------------------------------------------
    colorScheme: const ColorScheme(
      brightness: Brightness.light,

      primary: AppColors.primary,
      onPrimary: Colors.white,

      primaryContainer: Color(0xFFE9DDF5),
      onPrimaryContainer: AppColors.primary,

      secondary: AppColors.secondary,
      onSecondary: Colors.white,

      secondaryContainer: Color(0xFFE8DDF0),
      onSecondaryContainer: AppColors.secondary,

      tertiary: AppColors.tertiary,
      onTertiary: Colors.white,

      tertiaryContainer: Color(0xFFEEDDF2),
      onTertiaryContainer: AppColors.tertiary,

      error: AppColors.red,
      onError: Colors.white,

      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),

      surface: AppColors.surface,
      onSurface: AppColors.textDark,

      surfaceContainerHighest: Color(0xFFF0EDF2),
      onSurfaceVariant: Color(0xFF625D66),

      outline: Color(0xFF817A84),
      outlineVariant: AppColors.divider,

      inverseSurface: AppColors.primary,
      onInverseSurface: Colors.white,

      inversePrimary: AppColors.springGreen,

      scrim: Colors.black,
    ),

    // ------------------------------------------------------------
    // SCAFFOLD
    // ------------------------------------------------------------
    scaffoldBackgroundColor: AppColors.scaffoldLight,

    // ------------------------------------------------------------
    // APP BAR
    // ------------------------------------------------------------
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // ------------------------------------------------------------
    // CARDS
    // ------------------------------------------------------------
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      shadowColor: AppColors.glassShadow,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
    ),

    // ------------------------------------------------------------
    // DIVIDERS
    // ------------------------------------------------------------
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    // ------------------------------------------------------------
    // INPUTS
    // ------------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.divider),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.divider),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red, width: 2),
      ),

      hintStyle: const TextStyle(color: Color(0xFF8A8A8A)),

      labelStyle: const TextStyle(color: AppColors.textLight),

      floatingLabelStyle: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),

      prefixIconColor: AppColors.primary,
      suffixIconColor: AppColors.primary,
    ),

    // ------------------------------------------------------------
    // BOTONES ELEVADOS
    // ------------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.button,
        foregroundColor: Colors.white,

        elevation: 0,

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),

    // ------------------------------------------------------------
    // BOTONES FILLED
    // ------------------------------------------------------------
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),

    // ------------------------------------------------------------
    // BOTONES OUTLINED
    // ------------------------------------------------------------
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,

        side: const BorderSide(color: AppColors.primary, width: 1.2),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),

    // ------------------------------------------------------------
    // TEXT BUTTON
    // ------------------------------------------------------------
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,

        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),

    // ------------------------------------------------------------
    // ICONOS
    // ------------------------------------------------------------
    iconTheme: const IconThemeData(color: AppColors.primary, size: 24),

    // ------------------------------------------------------------
    // CHECKBOX
    // ------------------------------------------------------------
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }

        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      side: const BorderSide(color: AppColors.primary, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // ------------------------------------------------------------
    // SWITCH
    // ------------------------------------------------------------
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.springGreen;
        }

        return Colors.grey;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }

        return AppColors.divider;
      }),
    ),

    // ------------------------------------------------------------
    // RADIO
    // ------------------------------------------------------------
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }

        return AppColors.textLight;
      }),
    ),

    // ------------------------------------------------------------
    // PROGRESS INDICATORS
    // ------------------------------------------------------------
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.divider,
      circularTrackColor: AppColors.divider,
    ),

    // ------------------------------------------------------------
    // CHIPS
    // ------------------------------------------------------------
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFF0EAF5),
      selectedColor: AppColors.primary,
      disabledColor: AppColors.divider,

      labelStyle: const TextStyle(color: AppColors.primary),

      secondaryLabelStyle: const TextStyle(color: Colors.white),

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      side: BorderSide.none,
    ),

    // ------------------------------------------------------------
    // SNACKBAR
    // ------------------------------------------------------------
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primary,
      contentTextStyle: const TextStyle(color: Colors.white),
      actionTextColor: AppColors.springGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
    ),

    // ------------------------------------------------------------
    // DIALOGOS
    // ------------------------------------------------------------
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 8,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      titleTextStyle: const TextStyle(
        color: AppColors.primary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      contentTextStyle: const TextStyle(
        color: AppColors.textDark,
        fontSize: 15,
      ),
    ),

    // ------------------------------------------------------------
    // BOTTOM SHEET
    // ------------------------------------------------------------
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      modalBackgroundColor: Colors.white,
      showDragHandle: true,
    ),

    // ------------------------------------------------------------
    // TAB BAR
    // ------------------------------------------------------------
    tabBarTheme: const TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textLight,
      indicatorColor: AppColors.accent,
      dividerColor: AppColors.divider,
    ),

    // ------------------------------------------------------------
    // TOOLTIP
    // ------------------------------------------------------------
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(color: Colors.white),
    ),
  );

  // ============================================================
  // TEMA OSCURO
  // ============================================================

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // ------------------------------------------------------------
    // COLORES PRINCIPALES
    // ------------------------------------------------------------
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,

      primary: AppColors.springGreen,
      onPrimary: AppColors.primary,

      primaryContainer: AppColors.secondary,
      onPrimaryContainer: AppColors.springGreen,

      secondary: AppColors.accent,
      onSecondary: Colors.white,

      secondaryContainer: AppColors.secondary,
      onSecondaryContainer: Colors.white,

      tertiary: AppColors.tertiary,
      onTertiary: Colors.white,

      tertiaryContainer: AppColors.secondary,
      onTertiaryContainer: Colors.white,

      error: Color(0xFFFF6B6B),
      onError: Colors.black,

      errorContainer: Color(0xFF5C1A1A),
      onErrorContainer: Color(0xFFFFDAD6),

      surface: Color(0xFF11091C),
      onSurface: Color(0xFFF4EFF7),

      surfaceContainerHighest: Color(0xFF2A2032),
      onSurfaceVariant: Color(0xFFD0C6D5),

      outline: Color(0xFF938899),
      outlineVariant: Color(0xFF413746),

      inverseSurface: Color(0xFFF4EFF7),
      onInverseSurface: AppColors.primary,

      inversePrimary: AppColors.primary,

      scrim: Colors.black,
    ),

    // ------------------------------------------------------------
    // SCAFFOLD
    // ------------------------------------------------------------
    scaffoldBackgroundColor: const Color(0xFF0D0715),

    // ------------------------------------------------------------
    // APP BAR
    // ------------------------------------------------------------
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF11091C),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,

      iconTheme: IconThemeData(color: Colors.white),

      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // ------------------------------------------------------------
    // CARDS
    // ------------------------------------------------------------
    cardTheme: CardThemeData(
      color: const Color(0xFF1A1124),
      elevation: 2,
      shadowColor: Colors.black54,
      surfaceTintColor: Colors.transparent,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF30243A), width: 0.7),
      ),

      margin: const EdgeInsets.all(8),
    ),

    // ------------------------------------------------------------
    // DIVIDERS
    // ------------------------------------------------------------
    dividerTheme: const DividerThemeData(
      color: Color(0xFF30243A),
      thickness: 1,
      space: 1,
    ),

    // ------------------------------------------------------------
    // INPUTS
    // ------------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1124),

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3A2D44)),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3A2D44)),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.springGreen, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red, width: 2),
      ),

      hintStyle: const TextStyle(color: Color(0xFF918798)),

      labelStyle: const TextStyle(color: Color(0xFFBDB3C2)),

      floatingLabelStyle: const TextStyle(
        color: AppColors.springGreen,
        fontWeight: FontWeight.w600,
      ),

      prefixIconColor: AppColors.springGreen,
      suffixIconColor: AppColors.springGreen,
    ),

    // ------------------------------------------------------------
    // BOTONES ELEVADOS
    // ------------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.button,
        foregroundColor: Colors.white,

        elevation: 0,

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),

    // ------------------------------------------------------------
    // BOTONES FILLED
    // ------------------------------------------------------------
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.springGreen,
        foregroundColor: AppColors.primary,

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
    ),

    // ------------------------------------------------------------
    // BOTONES OUTLINED
    // ------------------------------------------------------------
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.springGreen,

        side: const BorderSide(color: AppColors.springGreen, width: 1.2),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),

    // ------------------------------------------------------------
    // TEXT BUTTON
    // ------------------------------------------------------------
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.springGreen,

        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),

    // ------------------------------------------------------------
    // ICONOS
    // ------------------------------------------------------------
    iconTheme: const IconThemeData(color: AppColors.springGreen, size: 24),

    // ------------------------------------------------------------
    // CHECKBOX
    // ------------------------------------------------------------
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.springGreen;
        }

        return Colors.transparent;
      }),

      checkColor: WidgetStateProperty.all(AppColors.primary),

      side: const BorderSide(color: AppColors.springGreen, width: 1.5),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // ------------------------------------------------------------
    // SWITCH
    // ------------------------------------------------------------
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.springGreen;
        }

        return const Color(0xFF938899);
      }),

      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.secondary;
        }

        return const Color(0xFF30243A);
      }),

      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),

    // ------------------------------------------------------------
    // RADIO
    // ------------------------------------------------------------
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.springGreen;
        }

        return const Color(0xFF938899);
      }),
    ),

    // ------------------------------------------------------------
    // PROGRESS INDICATORS
    // ------------------------------------------------------------
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.springGreen,
      linearTrackColor: Color(0xFF30243A),
      circularTrackColor: Color(0xFF30243A),
    ),

    // ------------------------------------------------------------
    // CHIPS
    // ------------------------------------------------------------
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF2A2032),
      selectedColor: AppColors.secondary,
      disabledColor: const Color(0xFF30243A),

      labelStyle: const TextStyle(color: Colors.white),

      secondaryLabelStyle: const TextStyle(color: AppColors.springGreen),

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      side: const BorderSide(color: Color(0xFF413746)),
    ),

    // ------------------------------------------------------------
    // SNACKBAR
    // ------------------------------------------------------------
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF2A2032),

      contentTextStyle: const TextStyle(color: Colors.white),

      actionTextColor: AppColors.springGreen,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      behavior: SnackBarBehavior.floating,
    ),

    // ------------------------------------------------------------
    // DIALOGOS
    // ------------------------------------------------------------
    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xFF1A1124),
      surfaceTintColor: Colors.transparent,
      elevation: 8,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      titleTextStyle: const TextStyle(
        color: AppColors.springGreen,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      contentTextStyle: const TextStyle(color: Color(0xFFE5DDE8), fontSize: 15),
    ),

    // ------------------------------------------------------------
    // BOTTOM SHEET
    // ------------------------------------------------------------
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF11091C),
      surfaceTintColor: Colors.transparent,
      modalBackgroundColor: Color(0xFF11091C),
      showDragHandle: true,
    ),

    // ------------------------------------------------------------
    // TAB BAR
    // ------------------------------------------------------------
    tabBarTheme: const TabBarThemeData(
      labelColor: AppColors.springGreen,
      unselectedLabelColor: Color(0xFF9F95A5),
      indicatorColor: AppColors.springGreen,
      dividerColor: Color(0xFF30243A),
    ),

    // ------------------------------------------------------------
    // TOOLTIP
    // ------------------------------------------------------------
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(color: Colors.white),
    ),
  );
}
