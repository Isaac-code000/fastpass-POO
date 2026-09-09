enum FormaPagamento { PIX, DEBITO }

enum StatusRecarga { PENDENTE, CONFIRMADA, CANCELADA }

class Recarga {
  final int id;
  final double valor;
  final String data;
  final StatusRecarga status;
  final double saldoAtual;

  Recarga({
    required this.id,
    required this.valor,
    required this.data,
    required this.status,
    required this.saldoAtual,
  });

  factory Recarga.fromJson(Map<String, dynamic> json) {
    return Recarga(
      id: json['id'],
      valor: (json['valor'] as num).toDouble(),
      data: json['data'],
      status: StatusRecarga.values.byName(json['status']),
      saldoAtual: json['saldoAtual'] != null
          ? (json['saldoAtual'] as num).toDouble()
          : 0.0,
    );
  }
}