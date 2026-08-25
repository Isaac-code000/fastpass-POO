import '../../core/api_client.dart';
import '../../models/linha.dart';

class LinhasService {
  static Future<List<Linha>> listarLinhas() async {
    final resultado = await ApiClient.get('/linhas');
    return (resultado as List).map((e) => Linha.fromJson(e)).toList();
  }

  static Future<List<Horario>> listarHorarios(int linhaId) async {
    final resultado = await ApiClient.get('/linhas/$linhaId/horarios');
    return (resultado as List).map((e) => Horario.fromJson(e)).toList();
  }
}
