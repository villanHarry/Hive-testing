import 'package:hive/hive.dart';
import 'package:hive_test/Enteries.dart';

class Boxes {
  static Box<Enteries> getEnteries() => Hive.box<Enteries>('enteries');
}
