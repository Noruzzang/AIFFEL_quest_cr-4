# AIFFEL Campus Online Code Peer Review Templete
- 코더 : 김승기
- 리뷰어 : 조규원

# PRT(Peer Review Template)
- [ ]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
   네
    ![화면 캡처 2024-10-28 173237](https://github.com/user-attachments/assets/1f1521eb-7e9a-4200-bbff-6a7338ae1dc9)

- [ ]  **2. 전체 코드에서 가장 핵심적이거나 가장 복잡하고 이해하기 어려운 부분에 작성된 
주석 또는 doc string을 보고 해당 코드가 잘 이해되었나요?**
   ![화면 캡처 2024-10-28 173402](https://github.com/user-attachments/assets/aee95ade-f412-4015-82f3-c0892f2a4c65)

        
- [ ]  **3. 에러가 난 부분을 디버깅하여 문제를 해결한 기록을 남겼거나
새로운 시도 또는 추가 실험을 수행해봤나요?**
  리뷰를 통해 설명을 들었는데 에러 없이 실행되었다고 들었습니다

- [ ]  **4. 회고를 잘 작성했나요?**
    회고를 미처 작성하지 못했다고 말씀해주셨지만 피어리뷰를 통해 상세한 설명과 회고를 들었습니다.
         
- [ ]  **5. 코드가 간결하고 효율적인가요?**
 // Import necessary Flutter packages
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(JellyfishClassifierApp());

class JellyfishClassifierApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jellyfish Classifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JellyfishClassifierPage(),
    );
  }
}

class JellyfishClassifierPage extends StatefulWidget {
  @override
  _JellyfishClassifierPageState createState() =>
      _JellyfishClassifierPageState();
}

class _JellyfishClassifierPageState extends State<JellyfishClassifierPage> {
  String score = "";
  String label = "";
  String failResult = "";
  String _imagePath = 'jellyfish/jellyfish.jpg'; // Example image path

  Future<void> fetchLabel() async {
    try {
      final enteredUrl = "http://127.0.0.1:5000/";
      final response = await http.get(
        Uri.parse(enteredUrl + "sample"),
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          label = "predicted_label: ${data['predicted_label']}";
        });
        print(label);
      } else {
        setState(() {
          failResult =
              "Failed to fetch data. Status Code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        failResult = "Error: $e";
      });
    }
  }

  Future<void> fetchScore() async {
    try {
      final enteredUrl = "http://127.0.0.1:5000/";
      final response = await http.get(
        Uri.parse(enteredUrl + "sample"),
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          score = "prediction_score: ${data['prediction_score']}";
        });
        print(score);
      } else {
        setState(() {
          failResult =
              "Failed to fetch data. Status Code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        failResult = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.filter_vintage), // ICON
            SizedBox(width: 8),
            Text('Jellyfish Classifier'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.asset('../jellyfish/jellyfish.jpg'),
            ),
            SizedBox(height: 16),
            Text(label),
            Text(score),
            Text(failResult),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    fetchLabel();
                  },
                  child: Text('예측 결과'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    fetchScore();
                  },
                  child: Text('예측 확률'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

네 그렇습니다

# 회고(참고 링크 및 코드 개선)
```
멋져용
```
