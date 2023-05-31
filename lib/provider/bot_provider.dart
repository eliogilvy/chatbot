import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';

class BotProvider with ChangeNotifier {
  Future<String> getBotResponse(Map<String, dynamic> body) async {
    final url = Uri.parse('http://127.0.0.1:8080/test');
    final response = await post(
      url,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    final data = jsonDecode(response.body);

    final botResponse = data['message'];
    final botAudio = data['audio'];
    Uint8List audio = base64Decode(botAudio);
    final player = AudioPlayer();
    player.setAudioSource(ByteStream(bytes: audio));
    player.play();

    
    return botResponse;
  }
}

class ByteStream extends StreamAudioSource {
  ByteStream({required this.bytes});

  final Uint8List bytes;

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    return StreamAudioResponse(
        sourceLength: bytes.length,
        contentLength: (start ?? 0) - (end ?? bytes.length),
        offset: start ?? 0,
        stream: Stream.fromIterable([bytes.sublist(start ?? 0, end)]),
        contentType: 'audio/mp3');
  }
}
