import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

class Posts extends StatefulWidget {
  final String title;
  final String content;

  Posts({required this.title, required this.content});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<Posts> {
  List<String> comments = [];
  String? aiResponse;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAIResponse();
    _loadComments();
  }

  Future<void> _loadAIResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      aiResponse = prefs.getString('ai_response_${widget.title}');
    });

    // 만약 저장된 AI 응답이 없다면, 새로 생성
    if (aiResponse == null) {
      _generateAIResponse();
    }
  }

  Future<void> _generateAIResponse() async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyCRl81h94xe_ZIeWfl5CnjqAxP2slyspXg',
      generationConfig: GenerationConfig(
        temperature: 0.4,
        topP: 0.95,
        maxOutputTokens: 8192,
      ),
    );

    final prompt =
        "제목: ${widget.title}\n내용: ${widget.content}\n위 내용에 대한 답변을 작성해 주세요.";

    try {
      final chatSession = model.startChat();
      final response = await chatSession.sendMessage(Content.text(prompt));

      setState(() {
        aiResponse = response.text;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('ai_response_${widget.title}', aiResponse!);
    } catch (e) {
      print("AI 응답 생성 중 오류 발생: $e");
    }
  }

  Future<void> _loadComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedComments = prefs.getString('comments_${widget.title}');
    if (savedComments != null) {
      setState(() {
        comments = List<String>.from(json.decode(savedComments));
      });
    }
  }

  Future<void> _saveComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('comments_${widget.title}', json.encode(comments));
  }

  void _addComment(String comment) {
    setState(() {
      comments.add(comment);
    });
    _saveComments();
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 키보드가 올라올 때 화면 조정
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('게시글 상세보기'),
      ),
      body: SingleChildScrollView(
        // 스크롤 가능하게 설정
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(widget.content),
              SizedBox(height: 8),
              Divider(thickness: 1), // 본문과 AI 응답 사이 경계선
              SizedBox(height: 8),
              if (aiResponse != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AI 응답:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(aiResponse!),
                    SizedBox(height: 8),
                    Divider(thickness: 1), // AI 응답과 댓글 사이 경계선
                    SizedBox(height: 8),
                  ],
                ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(comments[index]),
                  );
                },
              ),
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: '댓글을 입력하세요',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (commentController.text.isNotEmpty) {
                        _addComment(commentController.text);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
