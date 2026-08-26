import '../../core/api_client.dart';
import '../../models/passe.dart';

class PasseService {
  static Future<Passe> buscarPassePorUsuario(int usuarioId) async {
    final resultado = await ApiClient.get('/passes/usuario/$usuarioId');
    return Passe.fromJson(resultado);
  }
}