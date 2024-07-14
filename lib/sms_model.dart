import 'package:hive/hive.dart';

part 'sms_model.g.dart';

@HiveType(typeId: 0)
class SmsModel extends HiveObject {
  @HiveField(0)
  String message;

  @HiveField(1)
  String sender;

  @HiveField(2)
  DateTime receivedAt;

  SmsModel({required this.message, required this.sender, required this.receivedAt});
}
