import 'package:flutter/material.dart';

class WritePost extends StatefulWidget {
  @override
  _WritePostState createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _completeWriting() {
    String title = _titleController.text;
    String content = _contentController.text;
    Navigator.pop(context, {'title': title, 'content': content});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("글 쓰기"),
        actions: [
          TextButton(
            onPressed: _completeWriting,
            child: Text(
              "완료",
              style: TextStyle(color: Colors.red), // 버튼 텍스트 색상
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "제목",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              maxLines: 8,
              decoration: InputDecoration(
                labelText: "내용을 입력하세요.",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
