import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../database/app_preferences.dart';
import '../utils/constants.dart';
import 'strings/en-us.dart';
import 'strings/pt-br.dart';
class Lang extends Translations {
  static final Lang _instance = Lang._internal();

  factory Lang() {
    return _instance;
  }

  Lang._internal();

  @override
  Map<String, Map<String, String>> get keys => {'pt': pt_BR,'en': en_US};


  String languageCode() {
    var pref = Get.find<AppPreferences>();
    var localeMap = jsonDecode(pref.getLocalData(key: Constants.KEY_LOCALE) ??
        jsonEncode({
          'languageCode': Get.deviceLocale?.languageCode ?? 'en',
          'countryCode': Get.deviceLocale?.countryCode ?? 'US'
        }));
    var locale = Locale(localeMap['languageCode'], localeMap['countryCode']);

    return locale.languageCode;
  }
  Future<void> setLocale(Locale locale) async {
    var pref = Get.find<AppPreferences>();
    await pref.saveLocalData(
        key: Constants.KEY_LOCALE,
        data: jsonEncode({
          'languageCode': locale.languageCode,
          'countryCode': locale.countryCode
        }));
    Get.updateLocale(locale);
  }
  String countryCode() {
    var pref = Get.find<AppPreferences>();
    var localeMap = jsonDecode(pref.getLocalData(key: Constants.KEY_LOCALE) ??
        jsonEncode({
          'languageCode': Get.deviceLocale?.languageCode ?? 'en',
          'countryCode': Get.deviceLocale?.countryCode ?? 'US'
        }));
    var locale = Locale(localeMap['languageCode'], localeMap['countryCode']);
    return locale.countryCode!;
  }

  String localeCode() => formatLocaleCode();

  Locale locale() => Locale(languageCode(), countryCode());

  Future<void> initializeLangSupported() async {
    List<String> lc = [];
    var index = 1;
    for (var locale
        in locales.map((e) => formatLocaleCodeWithLocale(e)).toList()) {
      lc.add("$index. $locale");
      index++;
      await initializeDateFormatting(locale, null);
    }
  }

  List<Locale> locales = [
    const Locale('pt', 'BR'),
    const Locale('en', 'US'),
    const Locale('es', 'ES'),
    const Locale('fr', 'FR'),
    const Locale('it', 'IT'),
  ];

  String formatLocaleCode() {
    String localCode =
        "${Get.locale?.languageCode ?? ''}_${Get.locale?.countryCode ?? ''}";
    if (localCode.split('_').isEmpty) {
      localCode = 'en_US';
    }

    return localCode;
  }

  String formatLocaleCodeWithLocale(Locale locale) {
    String localCode =
        "${locale.languageCode ?? ''}_${locale.countryCode ?? ''}";
    if (localCode.split('_').isEmpty) {
      localCode = 'en_US';
    }
    return localCode;
  }
}
