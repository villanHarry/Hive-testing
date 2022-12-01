import 'package:hive/hive.dart';

part 'Enteries.g.dart';

@HiveType(typeId: 0)
class Enteries extends HiveObject {
  @HiveField(0)
  late String Name;

  @HiveField(1)
  late String Email;

  @HiveField(2)
  late String Message;
}
