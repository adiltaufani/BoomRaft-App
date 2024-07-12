import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TesFirebase extends StatefulWidget {
  const TesFirebase({super.key});

  @override
  State<TesFirebase> createState() => _TesFirebaseState();
}

class _TesFirebaseState extends State<TesFirebase> {
  String realtimeValue = 'bian22';
  String getOnceValue = 'apiis22';
  @override
  Widget build(BuildContext context) {
    DatabaseReference _tesRef = FirebaseDatabase.instance.ref().child('count');
    _tesRef.onValue.listen((event) {
      setState(() {
        realtimeValue = event.snapshot.value.toString();
      });
    });
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(100),
        child: Column(
          children: [
            Text('asdasd : $realtimeValue'),
            Text('asdasd2 : $realtimeValue'),
          ],
        ),
      ),
    );
  }
}
