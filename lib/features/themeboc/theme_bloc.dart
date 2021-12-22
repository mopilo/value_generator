import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_value_generator/core/settings/app_themes.dart';

import 'theme_events.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  //
  ThemeBloc()
      : super(
    ThemeState(
      themeData: AppThemes.appThemeData[AppTheme.lightTheme],
    ),
  );

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeEvent) {
      yield ThemeState(
        themeData: AppThemes.appThemeData[event.appTheme],
      );
    }
  }
}
