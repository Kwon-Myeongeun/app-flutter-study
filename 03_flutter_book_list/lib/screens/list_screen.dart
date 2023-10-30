import 'package:flutter/material.dart';
import 'package:flutter_book_list/models/book.dart';
import 'package:flutter_book_list/repositories/book_repository.dart';
import 'package:flutter_book_list/screens/detail_screen.dart';

// 도서 목록 화면
class ListScreen extends StatelessWidget {
  // 표시할 도서 정보 취득
  final List<Book> books = BookRepository().getBooks();
  @override
  Widget build(BuildContext context) {
    // Scaffold로 기본 화면 구성
    return Scaffold(
      appBar: AppBar(
        title: Text('도서 목록 앱'),
      ),
      // ListView : 목록형 UI 생성 위젯
      // ListView.builder : 리스트 형태의 데이터(List<Book>)를 효율적으로 표시할 수 있게해줌
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return BookTile(book: books[index]);
        },
      ),
    );
  }
}

// 도서 상세 화면에 책 정보를 넘겨주기 위하여 책 정보(데이터 모델: Book)를 가지고 있는 BookTile 위젯을 정의
class BookTile extends StatelessWidget {
  final Book book;
  BookTile({required this.book});
  @override
  Widget build(BuildContext context) {
    // ListTile : 목록형 UI에 단일 항목을 표시하는데 사용하는 위젯
    // 체크박스, 더보기 같은 아이콘, 이미지, 텍스트(3줄 까지 표시 가능)등을 표시할 수 있다
    // onTap , onLongPress 또는 onCheckboxChanged 등의 콜백 함수를 제공하여 유저와의 상호작용 가능
    return ListTile(
      title: Text(book.title),
      leading: Image.network(book.image),
      onTap: () {
        // 도서 정보(book)을 도서 상세 화면에 전달하며 화면 이동
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailScreen(
            book: book,
          ),
        ));
      },
    );
  }
}
