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

  bool _carregando = true;
  bool _erroReal = false;
  Carteirinha? _carteirinha;

  @override
  void initState() {
    super.initState();
    _carregar();
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
      // null aqui significa "usuário não tem carteirinha" — estado
      // normal, não erro (ver CarteirinhaService).
      final carteirinha = await CarteirinhaService.buscarPorUsuario(usuarioId);
      setState(() => _carteirinha = carteirinha);
    } catch (e) {
      setState(() => _erroReal = true);
    } finally {
      setState(() => _carregando = false);
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
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.arrow_back, size: 16),
                      label: const Text('Voltar', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Minha Carteirinha', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  const Text('Documento estudantil', style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            Expanded(
              child: _carregando
                  ? const LoadingIndicator()
                  : _erroReal
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Não foi possível carregar a carteirinha.', textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      ElevatedButton(onPressed: _carregar, child: const Text('Tentar novamente')),
                    ],
                  ),
                ),
              )
                  : _carteirinha == null
              // Estado normal para quem não tem passe estudantil —
              // não é erro, é uma tela informativa.
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.badge_outlined, size: 56, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      const Text(
                        'Você não possui carteirinha estudantil',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Esse recurso é exclusivo para passes do tipo estudantil.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
              )
                  : SingleChildScrollView(
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
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 26,
                                backgroundColor: Colors.grey[300],
                                child: Icon(Icons.person, color: Colors.grey[600], size: 28),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_carteirinha!.nomeUsuario, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    Text('@${_carteirinha!.apelidoUsuario}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: (_carteirinha!.valida ? _verdePrimer : Colors.red).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: _carteirinha!.valida ? _verdePrimer : Colors.red),
                                ),
                                child: Text(
                                  _carteirinha!.valida ? 'Válida' : 'Inválida',
                                  style: TextStyle(color: _carteirinha!.valida ? _verdePrimer : Colors.red, fontWeight: FontWeight.w600, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(height: 1, color: _bordaCinza),
                          const SizedBox(height: 16),
                          _linhaInfo('Matrícula', _carteirinha!.matricula),
                          const SizedBox(height: 10),
                          _linhaInfo('Instituição', _carteirinha!.instituicao),
                          const SizedBox(height: 10),
                          _linhaInfo('Curso', _carteirinha!.curso),
                          const SizedBox(height: 10),
                          _linhaInfo('Validade', _carteirinha!.validade),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _azulHeader,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
              break;
            case 1:
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
              break;
            case 2:
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LinhasScreen()));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card_outlined), label: 'Recarga'),
          BottomNavigationBarItem(icon: Icon(Icons.article_outlined), label: 'Linhas'),
          BottomNavigationBarItem(icon: Icon(Icons.badge_outlined), label: 'Passe'),
        ],
      ),
    );
  }

  Widget _linhaInfo(String label, String valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        Text(valor, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ],
    );
  }
}