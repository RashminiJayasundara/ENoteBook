import 'package:e_note_book/pages/folder_page.dart';
import 'package:e_note_book/pages/login_page.dart';
import 'package:e_note_book/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'මගේ පොත',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: WelcomePage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/folders': (context) => FolderPage()
      },
    );
  }
}
