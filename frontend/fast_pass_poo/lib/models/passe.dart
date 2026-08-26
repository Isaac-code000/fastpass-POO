enum StatusPasse { ATIVO, BLOQUEADO, VENCIDO }

enum TipoPasse { COMUM, ESTUDANTIL, IDOSO }

class Passe {
  final int id;
  final double saldo;
  final String validade;
  final StatusPasse status;
  final TipoPasse tipo;

  Passe({
    required this.id,
    required this.saldo,
    required this.validade,
    required this.status,
    required this.tipo,
  });

  factory Passe.fromJson(Map<String, dynamic> json) {
    return Passe(
      id: json['id'],
      saldo: (json['saldo'] as num).toDouble(),
      validade: json['validade'],
      status: StatusPasse.values.byName(json['status']),
      tipo: TipoPasse.values.byName(json['tipo']),
    );
  }
}
