import 'dart:convert';
import 'dart:io'; // Importação adicionada para detectar a plataforma
import 'package:http/http.dart' as http;


class ApiClient {

  static const String baseUrl = 'http://localhost:8080';


  static Future<dynamic> get(String path) async {
    // Agora passa baseUrl sem o 'const' já que ela se tornou dinâmica
    final response = await http.get(Uri.parse('$baseUrl$path'));
    return _handleResponse(response);
  }

  static Future<dynamic> post(String path, Map<String, dynamic> body) async {
    // Agora passa baseUrl sem o 'const' já que ela se tornou dinâmica
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    }
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    throw ApiException(
      'HTTP ${response.statusCode} - ${response.body}',
      response.statusCode,
    );
  }
}

class ApiException implements Exception {
  final String mensagem;
  final int statusCode;

  ApiException(this.mensagem, this.statusCode);

  @override
  String toString() => mensagem;
}
