import '../../core/api_client.dart';
import '../../models/passe.dart';

class PasseService {
  static Future<Passe> buscarPassePorUsuario(int usuarioId) async {
    final resultado = await ApiClient.get('/passes/usuario/$usuarioId');
    return Passe.fromJson(resultado);
  }

  static Future<Passe> utilizarPasse(int passeId) async {
    final resultado = await ApiClient.post(
      '/passes/$passeId/utilizar',
      {},
    );

    return Passe.fromJson(resultado);
  }
}