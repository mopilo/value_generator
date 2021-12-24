import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netguru_value_generator/core/widget/text_widget.dart';
import 'package:netguru_value_generator/features/mainscreen/data/datasource/quote_dao.dart';

class Favorite extends StatefulWidget{
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {



  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: quoteDao.getListenable(),
        builder: (_, Box box, r) {
          var myFavorites = box.values.where((e) => e.fav == true).toList();

          if (myFavorites.isEmpty) {
            return Center(
              child: TextWidget(
                text: 'No Favorite Value(s) yet',
                style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyText1!.color
              ),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: myFavorites.length,
                itemBuilder: (context, index){
                  var favQuotes = myFavorites[index];
                  return  Card(
                    color: Theme.of(context).cardTheme.color,
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(
                        width: .5,
                        color: Colors.grey
                      )
                    ),
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextWidget(
                        text: favQuotes.quotes,
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyText1!.color
                        ),
                      ),
                    ),
                  );
                }
            );
          }
        });
  }
}
