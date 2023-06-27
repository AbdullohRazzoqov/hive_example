import 'package:hive_flutter/adapters.dart';
part 'catigory_model.g.dart';

@HiveType(typeId: 2)
class Category extends HiveObject {
  @HiveField(0)
  String catigoryName;

  @HiveField(1)
  bool catigroyStatus;

  Category({
    required this.catigoryName,
    required this.catigroyStatus,
  });
}
