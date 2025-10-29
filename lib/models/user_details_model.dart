import 'package:hive_ce_flutter/adapters.dart';

part 'user_details_model.g.dart';
@HiveType(typeId: 2)
class UserDetailsModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String motivationQuote;
  UserDetailsModel({required this.motivationQuote, required this.name});
}
