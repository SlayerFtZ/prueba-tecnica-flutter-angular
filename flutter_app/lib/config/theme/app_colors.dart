import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ============================================================
  // PALETA PRINCIPAL
  // ============================================================

  static const primary = Color(0xFF190735);
  static const primaryBase = Color(0xFF400082);
  static const purple = Color(0xFF3D0082);

  static const springGreen = Color(0xFF4DFFA7);

  static const secondary = Color(0xFF311C51);
  static const tertiary = Color(0xFF633090);
  static const accent = Color(0xFF8D3293);
  static const highlight = Color(0xFFEF144D);

  // ============================================================
  // COLORES SEMÁNTICOS / ESTADOS
  // ============================================================

  static const info = Color(0xFF199AF7);
  static const red = Color(0xFFF71919);

  static const yellow = Color(0xFFFFC107);
  static const orange = Color(0xFFFF5722);
  static const lightBlue = Color(0xFF03A9F4);
  static const green = Color(0xFF4CAF50);

  static const blueMessage = Color(0xFF1460F8);

  // ============================================================
  // COLORES GENERALES
  // ============================================================

  static const white = Colors.white;
  static const black = Colors.black;
  static const grey = Colors.grey;
  static const transparent = Colors.transparent;

  // ============================================================
  // BOTONES Y ESTADOS
  // ============================================================

  static const button = Color(0xFFF96132);

  static const buttonPrimary = Color(0xFF190735);
  static const buttonPrimaryBase = Color(0xFF400082);

  static const buttonBlue = Color(0xFF050781);
  static const buttonGreen = Color(0xFF4CAF50);

  static const buttonText = Color(0xFF343A40);
  static const buttonCancel = Color(0xFFC60909);

  static const buttonShop = Color(0xFFF9F6A1);

  static const buttonSpringGreen = Color(0xFF4DFFA7);

  // Mantengo este nombre por compatibilidad
  // con código existente.
  static const buttonpurple = Color(0xFF3D0082);

  // Mantengo este nombre por compatibilidad
  // con código existente.
  static const buttonprimaryBase = Color(0xFF400082);

  static const buttonBlack = Colors.black;

  // ============================================================
  // TEXTOS
  // ============================================================

  static const textDark = Colors.black87;
  static const textLight = Color(0xFF757575);

  static const textPrimary = Color(0xFF190735);

  static const textspringGreen = Color(0xFF4DFFA7);

  static const textpurple = Color(0xFF3D0082);

  static const textRed = Color(0xFFFF3C00);

  static const textprimaryBase = Color(0xFF400082);

  // ============================================================
  // ESPECÍFICOS
  // ============================================================

  static const avatarBackground = Colors.white;

  static const phone = Color(0xFF2ECC71);
  static const birth = Color(0xFFF06292);
  static const gender = Color(0xFFBA68C8);
  static const document = Color(0xFF42A5F5);
  static const whatsapp = Color(0xFF25D366);

  static const start = Color(0xFFDDB44E);

  // ============================================================
  // LIQUID GLASS
  // ============================================================

  /// Brillo blanco suave típico del vidrio líquido.
  static const glassHighlight = Color.fromARGB(180, 255, 255, 255);

  /// Luz superior azulada.
  static const glassBlueLight = Color.fromARGB(90, 120, 170, 255);

  /// Sombra suave morada/azulada.
  static const glassShadow = Color.fromARGB(100, 40, 20, 70);

  /// Borde blanco difuminado.
  static const glassBorder = Color.fromARGB(140, 255, 255, 255);

  /// Capa translúcida para backgrounds con blur.
  static const glassBackground = Color.fromARGB(70, 255, 255, 255);

  /// Glow cálido.
  static const glassWarmGlow = Color.fromARGB(60, 255, 200, 150);

  // ============================================================
  // TIPOS DE PRODUCTO
  // ============================================================

  static const Color productTypeFisico = Color(0xFFF55B22);

  static const Color productTypeDigital = Color(0xFF008000);

  static const Color productTypeEbook = Color(0xFF7C29A8);

  static const Color productTypeAcademy = Color(0xFFDDB44E);

  static const Color productTypeKlanetTools = Color(0xFFF93848);

  // ============================================================
  // TIPOS DE PRODUCTO - VERSIONES LIGHT
  // ============================================================

  static const Color productTypeFisicoLight = Color.fromRGBO(245, 91, 34, 0.3);

  static const Color productTypeDigitalLight = Color.fromRGBO(0, 128, 0, 0.3);

  static const Color productTypeEbookLight = Color.fromRGBO(124, 41, 168, 0.3);

  static const Color productTypeAcademyLight = Color.fromRGBO(
    221,
    180,
    78,
    0.3,
  );

  static const Color productTypeKlanetToolsLight = Color.fromRGBO(
    194,
    0,
    0,
    0.6,
  );
  static const scaffoldLight = Color(0xFFF9F9F9);
  static const surface = Colors.white;
  static const divider = Color(0xFFEAEAEA);
  static const textHint = Color.fromARGB(255, 255, 255, 255);
}
