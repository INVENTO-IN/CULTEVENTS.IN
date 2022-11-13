import 'package:cult_events/service/email_services.dart';
import 'package:flutter/material.dart';

class IdeasScreen extends StatefulWidget {
  const IdeasScreen({Key? key}) : super(key: key);

  @override
  State<IdeasScreen> createState() => _IdeasScreenState();
}

class _IdeasScreenState extends State<IdeasScreen> {
  final String name = 'dhanush';
  final String email = 'dhanushsujatha123@gmail.com';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Hiii'),
      ),body: Column(
      children: [

        Center(child: ElevatedButton(onPressed: () {
          sendEmail(name: name, email: email);
        }, child: Text("Hiii")))
      ],
    ),
    );
  }
}
