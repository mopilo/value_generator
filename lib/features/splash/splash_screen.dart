import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_value_generator/features/mainscreen/home.dart';
import 'package:netguru_value_generator/core/settings/preferences.dart';
import 'package:netguru_value_generator/features/themeboc/theme_bloc.dart';
import 'package:netguru_value_generator/features/themeboc/theme_events.dart';

import 'splash_bloc.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late SplashCubit _splashCubit;

  @override
  void initState() {
    super.initState();
    _splashCubit = SplashCubit();
    BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(appTheme: Preferences.getTheme()));
  }

  @override
  void dispose() {
    _splashCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocProvider<SplashCubit>(
        create: (context) => _splashCubit,
        child: BlocConsumer<SplashCubit, SplashState>(
            listener: (BuildContext context, state) {
              if(state is SplashAuthorizedState){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const Home()));
              }
            },
            builder: (BuildContext context, state) => Scaffold(
              backgroundColor: Colors.grey,
              body: _body(context),
            )
        )
      );

  Widget _body(BuildContext context) => Container(
        alignment: Alignment.center,
        child: const CircleAvatar(
          backgroundImage: AssetImage("assets/playstore.png"),
          radius: 60,
        )

      );
}
