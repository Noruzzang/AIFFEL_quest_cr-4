import 'package:flutter/material.dart';

// Main entry point
void main() {
  runApp(EverytimeApp());
}

class EverytimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Everytime App Clone',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OnboardingScreen(),
    );
  }
}

// Onboarding Screen
class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
            'image/OnboardingScreen.jpg'), // Replace with your onboarding image asset
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.school,
            color: Colors.black), // Left Icon (school logo or Everytime logo)
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchBoxScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('에라문학생의 주인공은?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('시험기간만 되면 작가가 되는 나 ✍🏻')
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('중간고사.. 나만 어려웠나?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('실시간 시험 후기를 찾아보세요')
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.home, color: Colors.red),
                    SizedBox(height: 4),
                    Text('학교 홈'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.menu_book, color: Colors.red),
                    SizedBox(height: 4),
                    Text('열람실 현황'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.directions_bus, color: Colors.red),
                    SizedBox(height: 4),
                    Text('셔틀 버스'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.notifications, color: Colors.red),
                    SizedBox(height: 4),
                    Text('학사 공지'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.red),
                    SizedBox(height: 4),
                    Text('학사 일정'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              color: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '즐겨찾는 게시판',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BulletinBoardScreen()),
                            );
                          },
                          child: Text(
                            '더 보기',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          title: Text('자유게시판'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FreeBulletinBoardScreen()),
                            );
                          },
                        ),
                        ListTile(
                          title: Text('비밀게시판'),
                        ),
                        ListTile(
                          title: Text('졸업생 게시판'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: '시간표',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: '게시판',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: '채팅',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.campaign),
              label: '캠퍼스픽',
              backgroundColor: Colors.white),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BulletinBoardScreen()),
            );
          }
        },
      ),
    );
  }
}

// Bulletin Board Screen
class BulletinBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시판'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.note, color: Colors.blue),
            title: Text('내가 쓴 글'),
          ),
          ListTile(
            leading: Icon(Icons.comment, color: Colors.green),
            title: Text('댓글 단 글'),
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.amber),
            title: Text('스크랩'),
          ),
          ListTile(
            leading: Icon(Icons.whatshot, color: Colors.red),
            title: Text('HOT 게시판'),
          ),
          ListTile(
            leading: Icon(Icons.emoji_events, color: Colors.orange),
            title: Text('BEST 게시판'),
          ),
          Divider(),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.push_pin, color: Colors.red),
                  title: Text('자유게시판'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FreeBulletinBoardScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.push_pin, color: Colors.red),
                  title: Text('비밀게시판'),
                ),
                ListTile(
                  leading: Icon(Icons.push_pin, color: Colors.red),
                  title: Text('졸업생 게시판'),
                ),
                ListTile(
                  leading: Icon(Icons.push_pin, color: Colors.red),
                  title: Text('새내기게시판'),
                ),
                ListTile(
                  leading: Icon(Icons.push_pin, color: Colors.red),
                  title: Text('시사·이슈'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: '시간표',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: '게시판',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: '채팅',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.campaign),
              label: '캠퍼스픽',
              backgroundColor: Colors.white),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
      ),
    );
  }
}

// Free Bulletin Board Screen
// Free Bulletin Board Screen
class FreeBulletinBoardScreen extends StatefulWidget {
  @override
  _FreeBulletinBoardScreenState createState() =>
      _FreeBulletinBoardScreenState();
}

class _FreeBulletinBoardScreenState extends State<FreeBulletinBoardScreen> {
  List<Map<String, String>> posts = [];

  void addPost(String title, String content) {
    setState(() {
      posts.add({'title': title, 'content': content});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('자유게시판'),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchBoxScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index]['title']!),
                  subtitle: Text(posts[index]['content']!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(
                          title: posts[index]['title']!,
                          content: posts[index]['content']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WritePostScreen()),
                );
                if (result != null) {
                  addPost(result['title'], result['content']);
                }
              },
              child: Text('글쓰기'),
            ),
          ),
        ],
      ),
    );
  }
}

// Posts Detail Screen
class PostDetailScreen extends StatefulWidget {
  final String title;
  final String content;

  PostDetailScreen({required this.title, required this.content});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  List<String> comments = [];
  final TextEditingController commentController = TextEditingController();

  void addComment(String comment) {
    setState(() {
      comments.add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('게시글 상세보기'),
      ),
      body: Padding(
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
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(comments[index]),
                  );
                },
              ),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: '댓글을 입력하세요',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (commentController.text.isNotEmpty) {
                      addComment(commentController.text);
                      commentController.clear();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Write Post Screen
class WritePostScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('글쓰기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: '제목을 입력하세요',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: '내용을 입력하세요',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'title': titleController.text,
                  'content': contentController.text,
                });
              },
              child: Text('작성 완료'),
            ),
          ],
        ),
      ),
    );
  }
}

// Search Box Screen
class SearchBoxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(hintText: '글 제목, 내용, 해시태그'),
                onSubmitted: (value) {
                  print(value); // Print the search query to console
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                print('Search initiated'); // Print to console
              },
            ),
          ],
        ),
      ),
    );
  }
}
