import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'write_post.dart';
import 'posts.dart';

class Bulltein extends StatefulWidget {
  @override
  _BullteinState createState() => _BullteinState();
}

class _BullteinState extends State<Bulltein> {
  List<Map<String, String>> posts = [];
  bool isDeleteMode = false; // 글 삭제 모드 토글 변수
  Set<int> selectedPosts = {}; // 삭제할 글 인덱스 저장

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? postsData = prefs.getString('saved_posts');

    if (postsData != null) {
      try {
        List<dynamic> decodedData = json.decode(postsData);
        setState(() {
          posts = decodedData
              .map((data) => Map<String, String>.from(data as Map))
              .toList();
        });
      } catch (e) {
        print("데이터 로드 중 오류 발생: $e");
        setState(() {
          posts = [];
        });
      }
    }
  }

  Future<void> _savePosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String postsData = json.encode(posts);
    await prefs.setString('saved_posts', postsData);
  }

  Future<void> _saveLatestTitle(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('latest_title', title); // 최신 제목 저장
  }

  Future<void> _navigateToWritePost() async {
    if (!isDeleteMode) {
      // 삭제 모드가 아닐 때 글 작성 화면으로 이동
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WritePost()),
      );

      if (result != null && result is Map<String, String>) {
        setState(() {
          posts.add(result);
        });
        _savePosts(); // 글 목록 저장
        _saveLatestTitle(result['title'] ?? ""); // 최신 제목 저장
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Bulltein()),
        );
      }
    } else {
      // 삭제 모드일 때 선택된 글 삭제
      _deleteSelectedPosts();
    }
  }

  void _toggleDeleteMode() {
    setState(() {
      isDeleteMode = !isDeleteMode;
      selectedPosts.clear();
    });
  }

  void _togglePostSelection(int index) {
    setState(() {
      if (selectedPosts.contains(index)) {
        selectedPosts.remove(index);
      } else {
        selectedPosts.add(index);
      }
    });
  }

  void _deleteSelectedPosts() {
    setState(() {
      // 선택된 인덱스에 해당하지 않는 글만 남겨서 posts를 업데이트
      posts = posts
          .asMap()
          .entries
          .where((entry) => !selectedPosts.contains(entry.key))
          .map((entry) => entry.value)
          .toList();

      isDeleteMode = false; // 삭제 모드 종료
      selectedPosts.clear(); // 선택된 글 목록 초기화
      _savePosts(); // 변경된 글 목록 저장
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("질문게시판"),
        actions: [
          IconButton(
            icon: Icon(isDeleteMode ? Icons.close : Icons.delete),
            onPressed: _toggleDeleteMode, // 삭제 모드 토글 버튼
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            leading: isDeleteMode
                ? Checkbox(
                    value: selectedPosts.contains(index),
                    onChanged: (isSelected) {
                      _togglePostSelection(index);
                    },
                  )
                : null,
            title: Text(post['title'] ?? "제목 없음"),
            subtitle: Text(post['content'] ?? "내용 없음"),
            onTap: () {
              if (!isDeleteMode) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Posts(
                      title: post['title'] ?? "제목 없음",
                      content: post['content'] ?? "내용 없음",
                    ),
                  ),
                );
              } else {
                _togglePostSelection(index);
              }
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          onPressed: _navigateToWritePost,
          icon:
              Icon(isDeleteMode ? Icons.delete : Icons.edit, color: Colors.red),
          label: Text(
            isDeleteMode ? '선택 삭제' : '글 쓰기',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.grey),
          ),
          tooltip: isDeleteMode ? '선택된 글 삭제' : '글 쓰기',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
