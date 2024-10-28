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
