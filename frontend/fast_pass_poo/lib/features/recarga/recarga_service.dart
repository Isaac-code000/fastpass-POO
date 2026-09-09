import '../../core/api_client.dart';
import '../../models/recarga.dart';

class RecargaService {
  static Future<Recarga> recarregar({
    required int passeId,
    required double valor,
    required FormaPagamento formaPagamento,
  }) async {
    final resultado = await ApiClient.post('/recargas', {
      'passeId': passeId,
      'valor': valor,
      'formaPagamento': formaPagamento.name,
    });

    return Recarga.fromJson(resultado as Map<String, dynamic>);
  }
}
