import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool is_cat = true; // is_cat 변수 생성, bool, 초기값 true

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.pets), // 아이콘 추가
        title: Text('First Page'), // 타이틀 텍스트 추가
        centerTitle: true, // 앱바 텍스트 중앙 정렬
      ),
      body: Center(
        // 화면 중앙에 위젯 배치
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // 화면 중앙에 "Next" 버튼 추가
              onPressed: () {
                setState(() {
                  is_cat = false; // is_cat을 false로 초기화
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(
                        is_cat: is_cat), // 초기화한 변수 is_cat을 다음 페이지로 전달
                  ),
                ).then((_) {
                  // 두번째 페이지에서 다시 돌아올 때 실행되는 콜백함수
                  setState(() {
                    is_cat = true; // 첫 번째 페이지로 돌아올 때 is_cat을 true로 초기화
                  });
                  debugPrint('Back to is_cat: ${is_cat}'); // is_cat 상태 출력
                });
              },
              child: Text('Next'),
            ),

            SizedBox(height: 20), // 버튼과 이미지 사이 여백 추가

            GestureDetector(
              onTap: () {
                debugPrint(
                    'is_cat 현재 상태: $is_cat'); // 이미지 누르면 is_cat의 현재 상태를 DEBUG CONSOLE에 출력
              },
              child: Image.asset(
                'image/cat.png', // 고양이 이미지 (300x300)
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final bool is_cat;

  SecondPage({required this.is_cat});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.pets), // 강아지 모양 아이콘 추가
        title: Text('Second Page'), // 타이틀 텍스트 추가
        centerTitle: true, // 앱바 텍스트 중앙 정렬
      ),
      body: Center(
        // 화면 중앙에 위젯 배치
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // 화면 중앙에 "Back" 버튼 추가
              onPressed: () {
                Navigator.pop(context); // 생성했던 페이지 stack을 삭제 = navigator.pop
              },
              child: Text('Back'),
            ),

            SizedBox(height: 20), // 버튼과 이미지 사이 여백 추가

            GestureDetector(
              onTap: () {
                debugPrint(
                    'is_cat 현재 상태: ${widget.is_cat}'); // 이미지 누르면 is_cat의 현재 상태를 DEBUG CONSOLE에 출력
              },
              child: Image.asset(
                // 강아지 이미지 (300x300)
                'image/dog.png',
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 회고: is_cat의 상태를 secondPage에서 pop하기 전에 바꾸려고 하니 함수를 선언하여 
// firstPage에 넘겨주는 방법이 있었다. 그러나 그 흐름을 이해하지 못했다.
// 우선은 navigator.push 후 돌아왔을 때 실행할 수 있는 콜백함수를 사용하여
// 코드를 완성했다. 앞서 말한 방식은 더 알아봐야겠다.