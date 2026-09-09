import 'package:flutter/material.dart';
import '../../core/sessao_usuario.dart';
import '../../models/carteirinha.dart';
import '../../shared/loading_indicator.dart';
import '../../services/carteirinha_service.dart';
import '../home/home_screen.dart';
import '../linhas/linhas_screen.dart';

class CarteirinhaScreen extends StatefulWidget {
  const CarteirinhaScreen({super.key});

  @override
  State<CarteirinhaScreen> createState() => _CarteirinhaScreenState();
}

class _CarteirinhaScreenState extends State<CarteirinhaScreen> {
  static const Color _azulHeader = Color(0xFF1466C4);
  static const Color _verdePrimer = Color(0xFF1F883D);
  static const Color _bordaCinza = Color(0xFFD0D7DE);

  final _matriculaController = TextEditingController();
  final _instituicaoController = TextEditingController();
  final _cursoController = TextEditingController();

  bool _carregando = true;
  bool _cadastrando = false;
  bool _erroReal = false;
  Carteirinha? _carteirinha;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  void dispose() {
    _matriculaController.dispose();
    _instituicaoController.dispose();
    _cursoController.dispose();
    super.dispose();
  }

  Future<void> _carregar() async {
    setState(() {
      _carregando = true;
      _erroReal = false;
    });

    try {
      final usuarioId = SessaoUsuario.usuarioId;

      if (usuarioId == null) {
        throw Exception('Sessão inválida — faça login novamente.');
      }

      final carteirinha =
      await CarteirinhaService.buscarPorUsuario(usuarioId);

      if (!mounted) return;

      setState(() {
        _carteirinha = carteirinha;
      });
    } catch (e) {
      debugPrint('ERRO CARTEIRINHA: $e');

      if (!mounted) return;

      setState(() {
        _erroReal = true;
      });
    } finally {
      if (!mounted) return;

      setState(() {
        _carregando = false;
      });
    }
  }

  Future<void> _cadastrar() async {
    final matricula = _matriculaController.text.trim();
    final instituicao = _instituicaoController.text.trim();
    final curso = _cursoController.text.trim();

    if (matricula.isEmpty || instituicao.isEmpty || curso.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos.'),
        ),
      );
      return;
    }

    final usuarioId = SessaoUsuario.usuarioId;

    if (usuarioId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sessão inválida. Faça login novamente.'),
        ),
      );
      return;
    }

    setState(() {
      _cadastrando = true;
    });

    try {
      final carteirinha = await CarteirinhaService.cadastrar(
        usuarioId: usuarioId,
        matricula: matricula,
        instituicao: instituicao,
        curso: curso,
      );

      if (!mounted) return;

      setState(() {
        _carteirinha = carteirinha;
        _cadastrando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Carteirinha cadastrada com sucesso!'),
        ),
      );
    } catch (e) {
      debugPrint('ERRO AO CADASTRAR CARTEIRINHA: $e');

      if (!mounted) return;

      setState(() {
        _cadastrando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível cadastrar a carteirinha.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 16, 20, 20),
              color: _azulHeader,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: _azulHeader,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_back, size: 16),
                      label: const Text(
                        'Voltar',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Minha Carteirinha',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Documento estudantil',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _carregando
                  ? const LoadingIndicator()
                  : _erroReal
                  ? _buildErro()
                  : _carteirinha == null
                  ? _buildCadastro()
                  : _buildCarteirinha(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _azulHeader,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
                    (route) => false,
              );
              break;

            case 1:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
                    (route) => false,
              );
              break;

            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const LinhasScreen(),
                ),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_outlined),
            label: 'Recarga',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Linhas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined),
            label: 'Passe',
          ),
        ],
      ),
    );
  }

  Widget _buildErro() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 56,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 16),
            const Text(
              'Não foi possível carregar a carteirinha.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _carregar,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCadastro() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _bordaCinza),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _azulHeader.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.badge_outlined,
                        color: _azulHeader,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cadastre sua carteirinha',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Informe seus dados estudantis para utilizar o passe estudantil.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                _campo(
                  controller: _matriculaController,
                  label: 'Matrícula',
                  hint: 'Digite sua matrícula',
                  icon: Icons.numbers_outlined,
                ),
                const SizedBox(height: 14),
                _campo(
                  controller: _instituicaoController,
                  label: 'Instituição',
                  hint: 'Ex.: UFAPE',
                  icon: Icons.account_balance_outlined,
                ),
                const SizedBox(height: 14),
                _campo(
                  controller: _cursoController,
                  label: 'Curso',
                  hint: 'Ex.: Ciência da Computação',
                  icon: Icons.school_outlined,
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'A validade da carteirinha será definida automaticamente pelo sistema.',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: _cadastrando ? null : _cadastrar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _azulHeader,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: _cadastrando
                        ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Icon(Icons.check),
                    label: Text(
                      _cadastrando
                          ? 'Cadastrando...'
                          : 'Cadastrar carteirinha',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarteirinha() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _bordaCinza),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[600],
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _carteirinha!.nomeUsuario,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '@${_carteirinha!.apelidoUsuario}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (_carteirinha!.valida
                            ? _verdePrimer
                            : Colors.red)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _carteirinha!.valida
                              ? _verdePrimer
                              : Colors.red,
                        ),
                      ),
                      child: Text(
                        _carteirinha!.valida ? 'Válida' : 'Inválida',
                        style: TextStyle(
                          color: _carteirinha!.valida
                              ? _verdePrimer
                              : Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(
                  height: 1,
                  color: _bordaCinza,
                ),
                const SizedBox(height: 16),
                _linhaInfo(
                  'Matrícula',
                  _carteirinha!.matricula,
                ),
                const SizedBox(height: 10),
                _linhaInfo(
                  'Instituição',
                  _carteirinha!.instituicao,
                ),
                const SizedBox(height: 10),
                _linhaInfo(
                  'Curso',
                  _carteirinha!.curso,
                ),
                const SizedBox(height: 10),
                _linhaInfo(
                  'Validade',
                  _carteirinha!.validade,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _campo({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: _bordaCinza,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: _bordaCinza,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: _azulHeader,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _linhaInfo(String label, String valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            valor,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}