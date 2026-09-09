import 'package:fast_pass_poo/features/passe/passe_screen.dart';
import 'package:flutter/material.dart';
import '../../models/passe.dart';
import '../../core/sessao_usuario.dart';
import '../../services/passe_service.dart';
import '../recarga/recarga_screen.dart';
import '../linhas/linhas_screen.dart';
import '../carteirinha/carteirinha_screen.dart';
import '../passe/passe_screen.dart';
import '../pagamento/pagamento_aproximacao_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color _azulHeader = Color(0xFF1466C4);
  static const Color _verdePrimer = Color(0xFF1F883D);
  static const Color _bordaCinza = Color(0xFFD0D7DE);

  bool _carregando = true;
  String? _erro;
  Passe? _passe;

  @override
  void initState() {
    super.initState();
    _carregarPasse();
  }

  Future<void> _carregarPasse() async {
    setState(() {
      _carregando = true;
      _erro = null;
    });
    try {
      final usuarioId = SessaoUsuario.usuarioId;
      if (usuarioId == null) {
        throw Exception('Sessão inválida — faça login novamente.');
      }
      final passe = await PasseService.buscarPassePorUsuario(usuarioId);
      SessaoUsuario.passeId = passe.id;
      setState(() => _passe = passe);
    } catch (e) {
      debugPrint('ERRO PASSE: $e');
      setState(() => _erro = 'Não foi possível carregar seu passe.');
    } finally {
      setState(() => _carregando = false);
    }
  }

  Color _corDoStatus(StatusPasse status) {
    switch (status) {
      case StatusPasse.ATIVO:
        return _verdePrimer;
      case StatusPasse.BLOQUEADO:
        return Colors.orange[800]!;
      case StatusPasse.VENCIDO:
        return Colors.red[700]!;
    }
  }

  void _irParaRecarga() {
    if (_passe == null) return;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => RecargaScreen(passeId: _passe!.id)))
        .then((_) => _carregarPasse());
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              color: _azulHeader,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('FastPass', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Olá, ${SessaoUsuario.nome ?? "usuário"}', style: const TextStyle(color: Colors.white70, fontSize: 15)),
                ],
              ),
            ),
            Expanded(
              child: _carregando
                  ? const Center(child: CircularProgressIndicator())
                  : _erro != null
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_erro!, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      ElevatedButton(onPressed: _carregarPasse, child: const Text('Tentar novamente')),
                    ],
                  ),
                ),
              )
                  : RefreshIndicator(
                onRefresh: _carregarPasse,
                child: ListView(
                  padding: const EdgeInsets.all(20),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.widgets_outlined, color: _azulHeader, size: 20),
                                  const SizedBox(width: 8),
                                  Text('Saldo do passe', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _corDoStatus(_passe!.status).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: _corDoStatus(_passe!.status)),
                                ),
                                child: Text(
                                  _passe!.status.name[0] + _passe!.status.name.substring(1).toLowerCase(),
                                  style: TextStyle(color: _corDoStatus(_passe!.status), fontWeight: FontWeight.w600, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text('R\$ ${_passe!.saldo.toStringAsFixed(2).replaceAll('.', ',')}', style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text('Válido até ${_passe!.validade}', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton.icon(
                              onPressed: _irParaRecarga,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _verdePrimer,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              icon: const Icon(Icons.credit_card, size: 18),
                              label: const Text('Recarregar', style: TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Atalhos', style: TextStyle(color: Colors.grey[700], fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    _itemAtalho(
                      icone: Icons.article_outlined,
                      texto: 'Horários de Linhas',
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LinhasScreen())),
                    ),
                    const SizedBox(height: 10),
                    _itemAtalho(
                      icone: Icons.badge_outlined,
                      texto: 'Minha Carteirinha',
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CarteirinhaScreen())),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const PagamentoAproximacaoScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.contactless),
                        label: const Text(
                          'Pagar por aproximação',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _azulHeader,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        onTap: (index) {
          switch (index) {
            case 1:
              _irParaRecarga();
              break;
            case 2:
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LinhasScreen()));
              break;
            case 3:
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PasseScreen()));
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

  Widget _itemAtalho({required IconData icone, required String texto, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(color: const Color(0xFFF6F8FA), borderRadius: BorderRadius.circular(8), border: Border.all(color: _bordaCinza)),
        child: Row(
          children: [
            Icon(icone, size: 20, color: Colors.grey[700]),
            const SizedBox(width: 12),
            Text(texto, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}