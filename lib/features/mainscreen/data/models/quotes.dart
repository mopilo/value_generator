import 'package:hive/hive.dart';
part 'quotes.g.dart';

@HiveType(typeId: 1)
class Quotes {
  @HiveField(0)
  final String quotes;

  @HiveField(1)
  final bool fav;

  Quotes({
    required this.quotes,
    required this.fav,
  });
}
