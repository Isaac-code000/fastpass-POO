
class SessaoUsuario {
  static int? usuarioId;
  static String? nome;
  static int? carteirinhaId; // ainda sem endpoint no back — fica null por ora
  static int? passeId; // preenchido pela Home ao carregar o passe do usuário

  static void definirSessao(int id, String nomeUsuario) {
    usuarioId = id;
    nome = nomeUsuario;
  }

  static void limpar() {
    usuarioId = null;
    nome = null;
    carteirinhaId = null;
    passeId = null;
  }

  static bool get estaLogado => usuarioId != null;
}