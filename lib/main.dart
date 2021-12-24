import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netguru_value_generator/features/splash/splash_screen.dart';

import 'core/settings/preferences.dart';
import 'core/utils/hive_manager.dart';
import 'features/mainscreen/data/models/quotes.dart';
import 'features/mainscreen/presentation/bloc/themeboc/theme_bloc.dart';
import 'features/mainscreen/presentation/bloc/themeboc/theme_state.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(QuotesAdapter());
  await initialize();
  await Preferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ThemeBloc(),
    child: BlocBuilder<ThemeBloc, ThemeState>(
    builder: (BuildContext context, ThemeState themeState) {
      return MaterialApp(
          title: 'Value Generator',
          debugShowCheckedModeBanner: false,
          theme: themeState.themeData,
          home: const SplashScreen()
      );
    }));

  }
}

