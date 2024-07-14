import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SmsQuery query = SmsQuery();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    if (await Permission.sms.request().isGranted) {
      _fetchSms();
    }
  }

  Future<void> _fetchSms() async {
    var messages = await query.querySms(
      kinds: [SmsQueryKind.inbox],
      count: 10,
    );

    var box = Hive.box('smsBox');
    for (var message in messages) {
      box.put(message.id, {
        'address': message.address,
        'body': message.body,
        'date': message.date,
      });
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS App'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('smsBox').listenable(),
        builder: (context, Box box, widget) {if (box.values.isEmpty) {
          return Center(
            child: Text('No messages found'),
          );
        } else {
          // Reverse the list of messages
          List messages = box.values.toList().reversed.toList();
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var message = messages[index];
              Color cardColor = Colors.accents[index % Colors.accents.length];
              return Card(
                color: cardColor,
                child: ListTile(
                  title: Text(message['address']),
                  subtitle: Text(message['body']),
                  trailing: Text(message['date'].toString()),
                ),
              );
            },
          );
        }
        },
      ),
    );
  }
}