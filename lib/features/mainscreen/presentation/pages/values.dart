import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netguru_value_generator/features/mainscreen/data/datasource/quote_dao.dart';
import 'package:netguru_value_generator/features/mainscreen/data/models/quotes.dart';
import 'package:netguru_value_generator/features/mainscreen/presentation/widget/home_page_controller.dart';

import '../../../../core/widget/text_widget.dart';

class Values extends StatefulWidget{
  const Values({Key? key, this.controller}) : super(key: key);
  final HomePageController? controller;

  @override
  State<Values> createState() => _ValuesState();
}

class _ValuesState extends State<Values> {

  int _pos = 0;
  late Timer _timer;


  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      setState(() {
        _pos = (_pos + 1) % quoteDao.box.length;
      });
    });
    widget.controller!.methodA = methodA;
    super.initState();
  }






  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ValueListenableBuilder(
        valueListenable: quoteDao.getListenable(),
          builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return Center(
              child: TextWidget(
                  text: 'Empty',
                style: GoogleFonts.lato(
                    fontSize: 40
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: methodA,

              child: TextWidget(
                align: TextAlign.center,
                text:box.getAt(_pos).quotes,
                style: GoogleFonts.pacifico(
                    fontSize: 40,
                  color: Theme.of(context).textTheme.bodyText1!.color
                ),
              ),
            );
          }
        })
    );
  }


  methodA() {
    Quotes updateQuotes = Quotes(
      quotes: quoteDao.box.getAt(_pos).quotes,
      fav: true,
    );
    quoteDao.box.put(_pos, updateQuotes);
  }
}
