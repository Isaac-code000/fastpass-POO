import 'package:flutter/material.dart';
import '../../models/linha.dart';
import '../../shared/loading_indicator.dart';
import '../../shared/error_message.dart';
import '../home/home_screen.dart';
import '../recarga/recarga_screen.dart';
import '../carteirinha/carteirinha_screen.dart';
import 'linhas_service.dart';
import 'horarios_screen.dart';

class LinhasScreen extends StatefulWidget {
  const LinhasScreen({super.key});

  @override
  State<LinhasScreen> createState() => _LinhasScreenState();
}

class _LinhasScreenState extends State<LinhasScreen> {
  static const Color _azulHeader = Color(0xFF1466C4);
  static const Color _bordaCinza = Color(0xFFD0D7DE);

  bool _carregando = true;
  String? _erro;
  List<Linha> _linhas = [];

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() {
      _carregando = true;
      _erro = null;
    });
    try {
      final linhas = await LinhasService.listarLinhas();
      setState(() => _linhas = linhas);
    } catch (e) {
      setState(() => _erro = 'Não foi possível carregar as linhas.');
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
                  const Text(
                    'Horários de Linhas',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Selecione uma linha',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _carregando
                  ? const LoadingIndicator()
                  : _erro != null
                      ? ErrorMessage(mensagem: _erro!, onTentarNovamente: _carregar)
                      : _linhas.isEmpty
                          ? const Center(child: Text('Nenhuma linha cadastrada no momento.'))
                          : ListView(
                              padding: const EdgeInsets.all(20),
                              children: [
                                Text(
                                  '${_linhas.length} linhas disponíveis. Toque em uma linha para ver os horários.',
                                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                                ),
                                const SizedBox(height: 12),
                                ..._linhas.map((linha) => Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: _cardLinha(linha),
                                    )),
                              ],
                            ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _azulHeader,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false,
              );
              break;
            case 1:
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RecargaScreen()));
              break;
            case 3:
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CarteirinhaScreen()));
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

  Widget _cardLinha(Linha linha) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => HorariosScreen(linha: linha)),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _bordaCinza),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _azulHeader.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.directions_bus_filled_outlined, color: _azulHeader, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${linha.numero} · ${linha.nomeRota}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          linha.origem,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 12, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          linha.destino,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}