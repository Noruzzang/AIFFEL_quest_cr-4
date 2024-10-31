import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bulltein.dart';
import 'search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String latestTitle = "쉽다"; // 기본값 설정

  @override
  void initState() {
    super.initState();
    _loadLatestTitle();
  }

  Future<void> _loadLatestTitle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      latestTitle = prefs.getString('latest_title') ?? "쉽다";
    });
  }

  Future<void> _navigateToBulltein(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Bulltein()),
    );
    _loadLatestTitle(); // 자유게시판에서 돌아오면 최신 제목 다시 로드
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.month.toString().padLeft(2, '0')}월 ${now.day.toString().padLeft(2, '0')}일";

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.school, color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Search()),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade200],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('오늘의 할 일',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(formattedDate,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10)),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.add,
                                        color: Colors.grey, size: 12),
                                    onPressed: () {},
                                  ),
                                  Text('추가',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                  IconButton(
                                    icon: Icon(Icons.list,
                                        color: Colors.grey, size: 12),
                                    onPressed: () {},
                                  ),
                                  Text('전체 보기',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
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
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                          onTap: () {},
                          child: Text(
                            '더 보기',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color.fromARGB(255, 194, 194, 194)),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              '질문게시판',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              latestTitle, // 최근 제목 표시
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                            ),
                            trailing: Icon(Icons.new_releases,
                                color: Colors.red, size: 16),
                            onTap: () {
                              _navigateToBulltein(
                                  context); // 질문게시판 이동 후 최신 제목 갱신
                            },
                          ),
                          ListTile(
                            title: Text(
                              '졸업생게시판',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '새내기게시판',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '시사·이슈',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '장터게시판',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '정보게시판',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '취업·진로',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '홍보게시판',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '동아리·학회',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      ),
    );
  }
}
