class Carteirinha {
  final int id;
  final String matricula;
  final String instituicao;
  final String curso;
  final String validade;
  final bool valida;
  final String nomeUsuario;
  final String apelidoUsuario;

  Carteirinha({
    required this.id,
    required this.matricula,
    required this.instituicao,
    required this.curso,
    required this.validade,
    required this.valida,
    required this.nomeUsuario,
    required this.apelidoUsuario,
  });

  factory Carteirinha.fromJson(Map<String, dynamic> json) {
    return Carteirinha(
      id: json['id'],
      matricula: json['matricula'],
      instituicao: json['instituicao'],
      curso: json['curso'],
      validade: json['validade'],
      valida: json['valida'],
      nomeUsuario: json['nomeUsuario'],
      apelidoUsuario: json['apelidoUsuario'],
    );
  }
}