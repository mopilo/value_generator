import 'dart:convert';

import 'app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Preferences {
  //
  static SharedPreferences? preferences;
  static const String themeType = 'key_selected_theme';

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void saveTheme(AppTheme selectedTheme) async {
    if (null == selectedTheme) {
      selectedTheme = AppTheme.darkTheme;
    }
    String theme = jsonEncode(selectedTheme.toString());
    preferences!.setString(themeType, theme);
  }

  static AppTheme? getTheme() {
    String? theme = preferences!.getString(themeType);
    if (null == theme) {
      return AppTheme.darkTheme;
    }
    return getThemeFromString(jsonDecode(theme));
  }

  static AppTheme? getThemeFromString(String themeString) {
    for (AppTheme theme in AppTheme.values) {
      if (theme.toString() == themeString) {
        return theme;
      }
    }
    return null;
  }
}
