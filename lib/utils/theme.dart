import 'package:davi/davi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:system_theme/system_theme.dart';

import 'package:fluent_ui/fluent_ui.dart';

import '../services/theme_service.dart';
import 'constants.dart';

enum NavigationIndicators { sticky, end }

class AppTheme extends GetxController {
  AccentColor? _color;


  AccentColor get color => _color ?? blueDark;

  DaviThemeData? _daviThemeData;
  DaviThemeData get daviThemeData => _daviThemeData ?? (mode == ThemeMode.light
      ? daviThemeDataLight
      : daviThemeDataDark);


  set color(AccentColor color) {
    _color = color;
    update();
  }

  Color? _hintColor;

  Color get hintColor =>
      _hintColor ??
      (mode == ThemeMode.light
          ? Colors.black.withOpacity(0.6)
          : Colors.white.withOpacity(0.5));

  set hintColor(Color color) {
    _hintColor = color;
    update();
  }


  Color? _scaffoldBackgroundColor;
  Color? _cardColor;

  Color get scaffoldBackgroundColor => _scaffoldBackgroundColor ??
    (mode == ThemeMode.light ?
    const Color(0xFFEDEDFF)
        : const Color(0xFF282C34));


  set scaffoldBackgroundColor(Color color) {
    _scaffoldBackgroundColor = color;
    update();
  }

  Color get cardColor => _cardColor ??
      (mode == ThemeMode.light ?
      const Color(0xFFFFFFFF)
          : const Color(0xFF1E2021));

  Color get textColor =>
      (mode == ThemeMode.light ?
      black
          : const Color(0xFFFFFFFF));


  set cardColor(Color color) {
    _cardColor = color;
    update();
  }

  ThemeMode get mode => ThemeService().theme;



  Future< void > switchTheme(String themeMode) async  {
   await ThemeService().switchTheme(themeMode);
    update();
  }

  PaneDisplayMode _displayMode = PaneDisplayMode.auto;

  PaneDisplayMode get displayMode => _displayMode;

  set displayMode(PaneDisplayMode displayMode) {
    _displayMode = displayMode;
    update();
  }

  NavigationIndicators _indicator = NavigationIndicators.sticky;

  NavigationIndicators get indicator => _indicator;

  set indicator(NavigationIndicators indicator) {
    _indicator = indicator;
    update();
  }

  WindowEffect _windowEffect = WindowEffect.disabled;

  WindowEffect get windowEffect => _windowEffect;

  set windowEffect(WindowEffect windowEffect) {
    _windowEffect = windowEffect;
    update();
  }

  void setEffect(WindowEffect effect, BuildContext context) {
    Window.setEffect(
      effect: effect,
      color: [
        WindowEffect.solid,
        WindowEffect.acrylic,
      ].contains(effect)
          ? FluentTheme.of(context).micaBackgroundColor.withOpacity(0.05)
          : Colors.transparent,
      dark: FluentTheme.of(context).brightness.isDark,
    );
  }

  TextDirection _textDirection = TextDirection.ltr;

  TextDirection get textDirection => _textDirection;

  set textDirection(TextDirection direction) {
    _textDirection = direction;
    update();
  }

  Locale? _locale;

  Locale? get locale => _locale;

  set locale(Locale? locale) {
    _locale = locale;
    update();
  }
}

AccentColor get systemAccentColor {
  if ((defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.android) &&
      !kIsWeb) {
    return AccentColor.swatch({
      'darkest': SystemTheme.accentColor.darkest,
      'darker': SystemTheme.accentColor.darker,
      'dark': SystemTheme.accentColor.dark,
      'normal': SystemTheme.accentColor.accent,
      'light': SystemTheme.accentColor.light,
      'lighter': SystemTheme.accentColor.lighter,
      'lightest': SystemTheme.accentColor.lightest,
    });
  }
  return Colors.blue;
}
final AccentColor blueDark = AccentColor.swatch(const <String, Color>{
  'darkest': Color(0xffe80202),
  'darker': Color(0xffe80202),
  'dark': Color(0xffe80202),
  'normal': Color(0xffe80202),
  'light': Color(0xffe80202),
  'lighter': Color(0xffe80202),
  'lightest': Color(0xffe80202),
});
final AccentColor black = AccentColor.swatch(const <String, Color>{
  'darkest': Color(0xf2000000),
  'darker': Color(0xf2000000),
  'dark': Color(0xf2000000),
  'normal': Color(0xf2000000),
  'light': Color(0xf2000000),
  'lighter': Color(0xf2000000),
  'lightest': Color(0xf2000000),
});

Material.ThemeData lightThemeData(BuildContext context) {
  return Material.ThemeData.light().copyWith(

    primaryColor: Constants.kPrimaryColor,
    scaffoldBackgroundColor: Constants.kBaseColorLight,
    appBarTheme: appBarThemeLight(context),
    cardColor: Constants.kBaseCardColorLight,
    cardTheme: const Material.CardTheme(
        color: Constants.kBaseCardColorLight,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)))),
    iconTheme: const IconThemeData(color: Constants.kContentColorLightTheme),
    textTheme: GoogleFonts.mavenProTextTheme(Material.Theme
        .of(context)
        .textTheme).apply(
      bodyColor: Constants.kContentColorLightTheme,
      fontSizeFactor: 1.2,
    ),
    colorScheme: const Material.ColorScheme.light(
      primary: Constants.kPrimaryColor,
      secondary: Constants.kSecondaryColor,
      error: Constants.kErrorColor,
    ),
    hintColor: Constants.kContentSecondaryColorLightTheme,
    navigationBarTheme: Material.NavigationBarTheme.of(context)
        .copyWith(backgroundColor: Constants.kPrimaryColor),
  );
}

Material.ThemeData darkThemeData(BuildContext context) {
  return Material.ThemeData.dark().copyWith(
    primaryColor: Constants.kPrimaryColor,

    scaffoldBackgroundColor: Constants.kBaseColorDark,
    appBarTheme: appBarThemeDark(context),
    navigationBarTheme: Material.NavigationBarTheme.of(context)
        .copyWith(backgroundColor: Constants.kBaseColorDark),
    dividerTheme: const Material.DividerThemeData(
      thickness: 0, // set thickness to 0 to hide the divider
    ),
    cardTheme: const Material.CardTheme(
        color: Constants.kCardColorDarkTheme,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)))),
    iconTheme: const IconThemeData(color: Constants.kContentColorDarkTheme),
    textTheme: GoogleFonts.mavenProTextTheme(Material.Theme
        .of(context)
        .textTheme).apply(
      bodyColor: Constants.kContentColorDarkTheme,
      fontSizeFactor: 1.2,
    ),
    colorScheme: const Material.ColorScheme.dark().copyWith(
      primary: Constants.kPrimaryColor,
      onPrimary: Colors.white,
      secondary: Constants.kSecondaryColor,
      error: Constants.kErrorColor,
    ),
    hintColor: Constants.kContentSecondaryColorDarkTheme,
    cardColor: Constants.kCardColorDarkTheme,
    bottomNavigationBarTheme: Material.BottomNavigationBarThemeData(
      backgroundColor: Constants.kPrimaryColor,
      selectedItemColor: Material.Colors.white70,
      unselectedItemColor: Constants.kContentColorDarkTheme.withOpacity(0.32),
      selectedIconTheme: const IconThemeData(color: Colors.white),
      showUnselectedLabels: true,
    ),
  );
}

appBarThemeLight(BuildContext context) =>
    Material.AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Constants.kBaseColorLight,
      titleTextStyle: GoogleFonts
          .mavenProTextTheme(Material.Theme
          .of(context)
          .textTheme)
          .titleLarge!
          .copyWith(
          color: Constants.kContentColorLightTheme,
          fontSize: 26),
      iconTheme: const IconThemeData(
        color: Constants.kContentColorLightTheme,
      ),
    );

appBarThemeDark(BuildContext context) =>
    Material.AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Constants.kBaseColorDark,
      titleTextStyle: GoogleFonts
          .mavenProTextTheme(Material.Theme
          .of(context)
          .textTheme)
          .titleLarge!
          .copyWith(color: Constants.kContentColorDarkTheme, fontSize: 26),
      iconTheme: const IconThemeData(
        color: Constants.kContentColorDarkTheme,
      ),
    );


DaviThemeData daviThemeDataLight = DaviThemeData(
    scrollbar: TableScrollbarThemeData(
      borderThickness: 0,
      thickness: 4,
      radius: Radius.circular(16),
      thumbColor: blueDark,),
    decoration: BoxDecoration(
      color: Colors.transparent,
    ),

    columnDividerColor: Constants.kContentSecondaryColorLightTheme.withOpacity(0.2),
    row: RowThemeData(
      dividerColor: Constants.kContentSecondaryColorLightTheme.withOpacity(0.2),
    ),
    header: HeaderThemeData(
      columnDividerColor: Constants.kContentSecondaryColorLightTheme.withOpacity(0.2),
      bottomBorderColor: Constants.kContentSecondaryColorLightTheme.withOpacity(0.2),
    )
);
DaviThemeData daviThemeDataDark = DaviThemeData(
    scrollbar: TableScrollbarThemeData(
      borderThickness: 0,
      thickness: 4,
      radius: Radius.circular(16),
      thumbColor: blueDark,),
    decoration: BoxDecoration(
      color: Colors.transparent,
    ),
    columnDividerColor: Constants.kContentSecondaryColorDarkTheme.withOpacity(0.2),
    row: RowThemeData(
      dividerColor: Constants.kContentSecondaryColorDarkTheme.withOpacity(0.2),
    ),
    header: HeaderThemeData(
      columnDividerColor: Constants.kContentSecondaryColorDarkTheme.withOpacity(0.2),
      bottomBorderColor: Constants.kContentSecondaryColorDarkTheme.withOpacity(0.2),
    )
);
