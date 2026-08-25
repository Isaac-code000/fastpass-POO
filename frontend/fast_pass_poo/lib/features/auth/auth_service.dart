import '../../core/api_client.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(String apelido, String senha) async {
    final resultado = await ApiClient.post('/auth/login', {
      'apelido': apelido,
      'senha': senha,
    });
    return resultado as Map<String, dynamic>;
  }

  static Future<void> cadastrar({
    required String nome,
    required String email,
    required String cpf,
    required String apelido,
    required String senha,
  }) async {
    await ApiClient.post('/usuarios', {
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'apelido': apelido,
      'senha': senha,
    });
  }
}
