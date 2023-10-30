import 'package:flutter/material.dart';
import 'package:flutter_book_list/models/book.dart';

// 도서 상세 화면
class DetailScreen extends StatelessWidget {
  final Book book;
  // 이전 화면에서 넘겨받을 도서 정보(book)가 들어있는 생성자
  DetailScreen({required this.book});
  @override
  Widget build(BuildContext context) {
    // Scaffold로 기본 화면 구성
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Container(
        // Column : 세로로 위젯을 배치
        child: Column(
          children: [
            // Image : 도서 사진
            Image.network(book.image),
            // Padding : 여백
            Padding(
              padding: EdgeInsets.all(3),
            ),
            // Row : 가로로 제목, 좋아요 아이콘 위젯을 배치
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // MediaQuery : 화면의 사이즈를 가져올 때 사용한다
                  // MediaQuery.of(context).size.width 가 화면의 전체 가로 길이이며
                  // MediaQuery.of(context).size.width * 0.8로 전체 가로 길이의 80%를 차지하는 길이를 계산할 수 있다
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(10),
                  // 세로로 제목, 부제목 위젯 배치
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 주제목
                      // 주제목만 왜 Container로 또 감쌌을까?
                      /*Container(
                        child: Text(
                          book.title,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),*/
                      // Container빼고 돌리니까 UI 똑같음 ㅎ,,,
                      Text(
                        book.title,
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      // 부제목
                      Text(
                        book.subtitle,
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  // 전체 가로 길이의 80%를 제목 위젯이 차지하고 있으므로 나머지 위젯의 가로 길이는 20%보다 작아야 한다
                  // 즉, 위젯의 총 길이가 화면 길이를 넘어서는 안된다
                  width: MediaQuery.of(context).size.width * 0.15,
                  padding: EdgeInsets.all(10),
                  // 좋아요 아이콘
                  child: Center(
                    child: Icon(
                      Icons.star,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(3),
            ),
            // Row : 가로로 Contact, Route, Save 아이콘 배치
            // 아이콘에 콜백이 설정되어 있지 않으므로 아무 동작도 하지않는 아이콘이다
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Contact Icon
                Column(
                  children: [
                    Icon(
                      Icons.call,
                      color: Colors.blue,
                    ),
                    Text(
                      'Contact',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
                // Route Icon
                Column(
                  children: [
                    Icon(
                      Icons.near_me,
                      color: Colors.blue,
                    ),
                    Text(
                      'Route',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
                // Save Icon
                Column(
                  children: [
                    Icon(
                      Icons.save,
                      color: Colors.blue,
                    ),
                    Text(
                      'Save',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(book.description),
            )
          ],
        ),
      ),
    );
  }
}
