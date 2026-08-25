import 'dart:convert';
import 'package:http/http.dart' as http;

/// Cliente HTTP base, usado por todos os *_service.dart do app.
/// Centraliza a URL do backend e o tratamento de erro comum.
class ApiClient {
  // TODO: trocar pela URL real do backend quando o Controller estiver pronto.
  // Em emulador Android, "localhost" do PC vira "10.0.2.2".
  static const String baseUrl = 'http://localhost:8080';

  static Future<dynamic> get(String path) async {
    final response = await http.get(Uri.parse('$baseUrl$path'));
    return _handleResponse(response);
  }

  static Future<dynamic> post(String path, Map<String, dynamic> body) async {
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
    final erro = response.body.isNotEmpty
        ? (jsonDecode(response.body)['erro'] ?? 'Erro desconhecido')
        : 'Erro desconhecido';
    throw ApiException(erro.toString(), response.statusCode);
  }
}

class ApiException implements Exception {
  final String mensagem;
  final int statusCode;
  ApiException(this.mensagem, this.statusCode);

  @override
  String toString() => mensagem;
}
