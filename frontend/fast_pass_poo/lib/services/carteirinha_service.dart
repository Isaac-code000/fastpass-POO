import '../../core/api_client.dart';
import '../../models/carteirinha.dart';

class CarteirinhaService {
  static Future<Carteirinha?> buscarPorUsuario(int usuarioId) async {
    try {
      final resultado = await ApiClient.get('/carteirinhas/usuario/$usuarioId');
      return Carteirinha.fromJson(resultado);
    } on ApiException catch (e) {
      if (e.statusCode == 404) return null;
      rethrow;
    }
  }

static Future<Carteirinha> cadastrar({
required int usuarioId,
required String matricula,
required String instituicao,
required String curso,
}) async {
final resultado = await ApiClient.post('/carteirinhas', {
'usuarioId': usuarioId,
'matricula': matricula,
'instituicao': instituicao,
'curso': curso,
});

return Carteirinha.fromJson(resultado);
}}