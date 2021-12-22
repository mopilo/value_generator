import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/widget/text_widget.dart';
import 'home.dart';
import 'model/quotes.dart';

class Values extends StatefulWidget{
  const Values({Key? key, this.controller}) : super(key: key);
  final HomePageController? controller;

  @override
  State<Values> createState() => _ValuesState();
}

class _ValuesState extends State<Values> {
  late final Box box;

  int _pos = 0;
  late Timer _timer;



  @override
  void initState() {
    box = Hive.box('quoteBox');
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      setState(() {
        _pos = (_pos + 1) % box.length;
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
        valueListenable: box.listenable(),
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
      quotes: box.getAt(_pos).quotes,
      fav: true,
    );
    box.put(_pos, updateQuotes);
  }
}
