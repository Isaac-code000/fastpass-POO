import '../../core/api_client.dart';
import '../../models/recarga.dart';

class RecargaService {
  static Future<Recarga> buscarPorId(int id) async {
    final resultado = await ApiClient.get('/recargas/$id');
    return Recarga.fromJson(resultado);
  }

  static Future<Recarga> solicitar({
    required int passeId,
    required double valor,
    required FormaPagamento formaPagamento,
    String? chavePix,
    double? desconto,
  }) async {
    final resultado = await ApiClient.post('/recargas', {
      'passeId': passeId,
      'valor': valor,
      'formaPagamento': formaPagamento.name,
      if (chavePix != null) 'chavePix': chavePix,
      if (desconto != null) 'desconto': desconto,
    });
    return Recarga.fromJson(resultado);
  }

  static Future<Recarga> confirmar(int id) async {
    final resultado = await ApiClient.post('/recargas/$id/confirmar', {});
    return Recarga.fromJson(resultado);
  }
}