import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:hive/hive.dart';
import 'sms_model.dart';

void fetchSmsAndStore() async {
  SmsQuery query = SmsQuery();
  List<SmsMessage> messages = await query.querySms(kinds: [SmsQueryKind.inbox]);

  var box = Hive.box<SmsModel>('smsBox');

  for (var sms in messages) {
    var smsModel = SmsModel(
      message: sms.body ?? '',
      sender: sms.sender ?? '',
      receivedAt: sms.date ?? DateTime.now(),
    );
    box.add(smsModel);
  }
}
