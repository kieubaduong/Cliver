import 'dart:collection';
import 'dart:ui';

import 'package:get/get.dart';

import '../values/languages/en_US.dart';
import '../values/languages/vi_VN.dart';

class LocalizationService extends Translations {
  static final locale = _getLocaleFromLanguage();

  static const fallbackLocale = Locale('vi', 'VN');

  static final languageCodes = [
    'en',
    'vi',
  ];

  static final List displayLangList = [
    {'name': 'English(US)', 'languageCode': 'en'},
    {'name': 'Tiếng Việt', 'languageCode': 'vi'},
  ];

// các Locale được support
  static final locales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
  ];

  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });

  static void changeLocale(String languageCode) {
    final locale = _getLocaleFromLanguage(languageCode: languageCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enLanguagePackage,
        'vi_VN': viLanguagePackage,
      };

  static Locale _getLocaleFromLanguage({String? languageCode}) {
    final lang = languageCode ?? Get.deviceLocale!.languageCode;
    for (int i = 0; i < languageCodes.length; i++) {
      if (lang == languageCodes[i]) return locales[i];
    }
    return Get.locale!;
  }
}
