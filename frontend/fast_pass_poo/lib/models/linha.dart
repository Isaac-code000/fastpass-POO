class Linha {
  final int id;
  // Número identificador da linha, ex: "101".
  final String numero;
  // Nome descritivo da rota, ex: "Centro / Terminal Norte".
  // Diferente de origem/destino, que são os pontos de parada específicos.
  final String nomeRota;
  final String origem;
  final String destino;

  Linha({
    required this.id,
    required this.numero,
    required this.nomeRota,
    required this.origem,
    required this.destino,
  });

  factory Linha.fromJson(Map<String, dynamic> json) {
    return Linha(
      id: json['id'],
      numero: json['numero'],
      nomeRota: json['nomeRota'],
      origem: json['origem'],
      destino: json['destino'],
    );
  }
}

class Horario {
  final String horarioSaida;
  final String horarioChegada;
  // Texto já formatado como intervalo, ex: "Seg a Sex", "Seg a Sáb".
  // TODO: decidir com o grupo se essa formatação é feita no backend
  // (mais simples pro front) ou se o backend manda dias separados
  // (ex: ["SEGUNDA", "TERCA"...]) e o front agrupa em intervalo.
  final String diasSemana;

  Horario({
    required this.horarioSaida,
    required this.horarioChegada,
    required this.diasSemana,
  });

  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      horarioSaida: json['horarioSaida'],
      horarioChegada: json['horarioChegada'],
      diasSemana: json['diasSemana'],
    );
  }
}