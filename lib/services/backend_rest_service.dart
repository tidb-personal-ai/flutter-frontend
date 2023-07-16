import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

class BackendRestService {
  final String baseUrl;

  BackendRestService({
    required this.baseUrl,
  });

  Future<Map<String, String>> _getHeaders() async {    
    // Fetch the currentUser, and then get its id token 
    final user = FirebaseAuth.instance.currentUser!;
    final idToken = await user.getIdToken();

    // Create authorization header
    final header = { 
      'authorization': 'Bearer $idToken',
      'Content-Type': 'application/json'
    };
    return header;
  }
  
  Future<String> get(String method, [Map<String, dynamic>? queryParameters]) async {
    final uri = queryParameters != null 
      ? Uri.parse(baseUrl + method).replace(queryParameters: queryParameters)
      : Uri.parse(baseUrl + method);
    final response = await http.get(uri, headers: await _getHeaders());

    if (response.ok) {
      return response.body;
    } else {
      throw Exception('Getting method $method failed: ${response.statusCode} - ${response.body}');
    }
  }

  Future<String> post(String method, [Map<String, dynamic>? body]) async {
    final encodedBody = body != null ? jsonEncode(body) : null;
    final response = await http.post(Uri.parse(baseUrl + method), headers: await _getHeaders(), body: encodedBody);

    if (response.ok) {
      return response.body;
    } else {
      throw Exception('Posting method $method failed: ${response.statusCode} - ${response.body}');
    }
  }
}
