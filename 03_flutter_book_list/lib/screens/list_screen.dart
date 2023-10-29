import 'package:flutter/material.dart';
import 'package:flutter_book_list/models/book.dart';
import 'package:flutter_book_list/repositories/book_repository.dart';
import 'package:flutter_book_list/screens/detail_screen.dart';

class ListScreen extends StatelessWidget {
  final List<Book> books = BookRepository().getBooks(); // (refactoring) repository data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('도서 목록 앱'),
      ),
      body: ListView.builder( // list values -> ListView로!
        itemCount: books.length,
        itemBuilder: (context, index) {
          return BookTile(book: books[index]);
        },
      ),
    );
  }
}

// ListTitle -> detail_screen에 데이터 전달 불가 so, BookTitle 위젯 구현
// BookTitle -> ListTitle 위젯 return
class BookTile extends StatelessWidget {
  final Book book;
  BookTile({required this.book});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      leading: Image.network(book.image),
      onTap: () { // tap 시 이벤트 선언
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailScreen(
            book: book,
          ),
        ));
      },
    );
  }
}
