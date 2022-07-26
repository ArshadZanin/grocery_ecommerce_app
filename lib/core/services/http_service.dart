import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

class HTTPService{
  final r = RetryOptions(maxAttempts: 3);

  Future<http.Response> makeGetRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      Uri uri = Uri.tryParse(url)!;
      http.Response response = await r.retry(
        () => http.get(
          uri,
          headers: headers,
        ),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
      return response;
    } catch (error) {
      throw (error);
    }
  }
}
