import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netguru_value_generator/core/utils/constant.dart';
import 'package:netguru_value_generator/core/utils/hive_manager.dart';
import 'package:netguru_value_generator/features/mainscreen/data/models/quotes.dart';

late QuoteDao quoteDao;

class QuoteDao {
  late Box _box;

  Box get box => _box;

  QuoteDao() {
    openBox().then(
          (value) => _box = value,
    );
  }

  Future openBox() {
    return HiveBoxes.openBox(HiveBoxes.quotes);
  }

  Future<void> addQuotes(quotes) async {
    await _box.add(quotes);
  }
  Future<void> addQuotesOnLoad() async{
    if(_box.length == 0){
      for(String quote in quotes){
        await _box.add(Quotes(quotes: quote, fav: false));
      }
    }
  }

  ValueListenable<Box> getListenable() {
    return  _box.listenable();
  }


  Future truncate() async => await _box.clear();
}
