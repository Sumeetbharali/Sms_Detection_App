import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_app/intro_page.dart';
import 'package:new_app/landing.dart';
import 'package:new_app/sms_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('smsBox');
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask(
    '1',
    'fetchSms',
    frequency: Duration(seconds: 1),
  );
  runApp(MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final SmsQuery query = SmsQuery();
    var messages = await query.querySms(
      kinds: [SmsQueryKind.inbox],
      count: 10,
    );

    var box = await Hive.openBox('smsBox');
    for (var message in messages) {
      box.put(message.id, {
        'address': message.address,
        'body': message.body,
        'date': message.date,
      });
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMS App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroductionPages(),
      routes: {
        '/home':(context)=>MyHomePage(),
        '/land':(context)=>LandingPage()
      },
    );
  }
}

