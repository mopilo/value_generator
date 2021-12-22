
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:netguru_value_generator/core/settings/app_themes.dart';
import 'package:netguru_value_generator/core/settings/preferences.dart';
import 'package:netguru_value_generator/features/themeboc/theme_bloc.dart';
import 'package:netguru_value_generator/features/themeboc/theme_events.dart';
import 'package:netguru_value_generator/features/themeboc/theme_state.dart';

import '../../core/utils/const.dart';
import '../../core/utils/themes.dart';
import '../../core/widget/text_widget.dart';
import 'favorite.dart';
import 'model/quotes.dart';
import 'values.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late final Box box;
  late final HomePageController myController;

  //to handle which item is currently selected in the bottom app bar
  int selectedIndex = 0;

  TextEditingController controller = TextEditingController();

  final PageStorageBucket bucket = PageStorageBucket();


  @override
  void initState() {
    super.initState();
    box = Hive.box('quoteBox');
    myController = HomePageController();
    checker();
  }

  checker(){
    if(box.length == 0){
      for(String quote in quotes){
        box.add(Quotes(quotes: quote, fav: false));
      }
    }
  }

  //create
  late Widget currentScreen;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentScreen =   Values(controller: myController);

  }


  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index,  HomePageController controller) {
    setState(() {
      selectedIndex = index;
      currentScreen = index == 0 ?  Values(controller: controller) :  const Favorite();
    });
  }

  _setTheme(bool darkTheme) async {
    AppTheme selectedTheme = darkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
    Preferences.saveTheme(selectedTheme);
    BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(appTheme: selectedTheme));
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => BlocProvider.of<ThemeBloc>(context),
      child: BlocConsumer<ThemeBloc, ThemeState>(
        listener: (BuildContext context, state) {
         setState(() {});
        },
        builder: (BuildContext context, state) =>
            Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primary,
                elevation: 0.0,
                title: TextWidget(
                  text: "NG Values",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                  ),
                ),
                centerTitle: false,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ), onPressed: () {
                      myController.methodA();
                    },
                    ),
                  ),
                  Switch(
                    value: Preferences.getTheme() == AppTheme.darkTheme,
                    activeColor: Colors.black,
                    onChanged: (val) async {
                      _setTheme(val);
                    },
                  )
                ],
              ),
              body: PageStorage(
                child: currentScreen,
                bucket: bucket,
              ),

              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add, color: Colors.black),
                backgroundColor: Colors.white,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: TextWidget(
                            text:  "Add custom value",
                            style: GoogleFonts.lato(),
                          ),
                          content: Row(
                            children: [
                              Expanded(
                                  child:  TextField(
                                    maxLines: 7,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(color: AppColors.primary)
                                          ),
                                          hintText: 'Enter value',
                                      ),
                                      controller: controller
                                  )
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              child:  TextWidget(
                                  text: "Cancel",
                                style: GoogleFonts.lato(
                                  color: AppColors.primary
                                )
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),

                            TextButton(
                              child:  TextWidget(
                                  text: "Submit",
                                  style: GoogleFonts.lato(
                                      color: AppColors.primary
                                  )
                              ),
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  Quotes newQuotes = Quotes(
                                    quotes: controller.text,
                                    fav: false,
                                  );
                                  box.add(newQuotes);
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        );
                      }
                  );
                },
                elevation: 10.0,
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

              bottomNavigationBar: BottomAppBar(
                color: AppColors.primary,
                shape: const AutomaticNotchedShape(
                    RoundedRectangleBorder(),
                    StadiumBorder(side: BorderSide())
                ),
                notchMargin: 6,
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              updateTabSelection(0, myController);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  <Widget>[
                                Icon(
                                  Icons.format_quote,
                                  // color: Colors.white,
                                  size: 30,
                                  color: selectedIndex == 0 ? Colors.white : Colors.white70,
                                ),
                                Text(
                                  "Values",
                                  style: GoogleFonts.lato(
                                      color: selectedIndex == 0 ? Colors.white : Colors.white70,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Right Tab bar icons

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              updateTabSelection(1, myController);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  <Widget>[
                                Icon(
                                  Icons.favorite,
                                  color: selectedIndex == 1 ? Colors.white : Colors.white70,
                                ),
                                TextWidget(
                                  text: "Favorites",
                                  style: GoogleFonts.lato(
                                      color: selectedIndex == 1 ? Colors.white : Colors.white70,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
      ));

  }
}

class HomePageController {
  late Function() methodA;
}
