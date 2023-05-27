import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BotProvider with ChangeNotifier {
  String _botResponse = '';
  String get botResponse => _botResponse;

  Future<void> getBotResponse(Map<String, dynamic> body) async {
    final url = Uri.parse('http://127.0.0.1:8000/test');
    final response = await post(
      url,
      body: body,
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('data $data');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
