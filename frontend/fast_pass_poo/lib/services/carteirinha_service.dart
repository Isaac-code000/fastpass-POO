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
}