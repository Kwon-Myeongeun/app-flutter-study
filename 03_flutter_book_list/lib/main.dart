import 'package:flutter/material.dart';
import 'package:flutter_book_list/screens/list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book List App',
      // 도서 목록 화면
      home: ListScreen(),
    );
  }
}
