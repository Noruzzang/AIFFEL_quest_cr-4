import 'package:flutter/material.dart';

// Search Box Screen
class Search extends StatelessWidget {
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
