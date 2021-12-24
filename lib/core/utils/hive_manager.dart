import 'package:hive_flutter/adapters.dart';
import 'package:netguru_value_generator/features/mainscreen/data/datasource/quote_dao.dart';

/// initialize local data storage
Future<void> initialize() async {
  await Hive.initFlutter();
  await HiveBoxes.openAllBox();
}

class HiveBoxes {
  static const quotes = 'quoteBox';

  static Future openAllBox() async {
    quoteDao = QuoteDao();
  }

  static Future clearAllBox() async {
    await quoteDao.truncate();
  }

  static Future<Box<T>> openBox<T>(String boxName) async {
    Box<T> box;
    if (Hive.isBoxOpen(boxName)) {
      box = Hive.box<T>(boxName);
    } else {
      try {
        box = await Hive.openBox<T>(boxName);
      } catch (_) {
        await Hive.deleteBoxFromDisk(boxName);
        box = await Hive.openBox<T>(boxName);
      }
    }
    return box;
  }



}
