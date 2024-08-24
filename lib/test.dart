import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Network Test'),
        ),
        body: Center(
          child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Text('No data available');
              } else {
                return Text('Response: ${snapshot.data}');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    final url = 'https://jsonplaceholder.typicode.com/posts/1'; // Replace with your URL
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data != null && data is Map && data.containsKey('title')) {
          return data['title'];
        } else {
          throw Exception('Invalid data format');
        }
      } else if (response.statusCode == 404) {
        // Handle 404 error specifically
        return 'Error 404: Resource not found';
      } else {
        // Handle other HTTP errors
        throw Exception('Failed to load data: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}