import 'package:flutter/material.dart';
import 'package:get/get_connect/connect.dart';

import '../../app/core/core.dart';

class SentimentService extends GetConnect {
  SentimentService._initInstance();

  static final SentimentService ins = SentimentService._initInstance();

  Future<Response> getSentiment({required String text}) {
    return post(
      api_sentiment,
      [text],
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}