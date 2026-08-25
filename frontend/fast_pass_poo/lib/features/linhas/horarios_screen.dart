import 'package:flutter/material.dart';
import '../../models/linha.dart';
import '../../shared/loading_indicator.dart';
import '../../shared/error_message.dart';
import '../home/home_screen.dart';
import '../recarga/recarga_screen.dart';
import '../carteirinha/carteirinha_screen.dart';
import 'linhas_service.dart';

class HorariosScreen extends StatefulWidget {
  final Linha linha;

  const HorariosScreen({super.key, required this.linha});

  @override
  State<HorariosScreen> createState() => _HorariosScreenState();
}

class _HorariosScreenState extends State<HorariosScreen> {
  static const Color _azulHeader = Color(0xFF1466C4);
  static const Color _bordaCinza = Color(0xFFD0D7DE);

  bool _carregando = true;
  String? _erro;
  List<Horario> _horarios = [];

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
      final horarios = await LinhasService.listarHorarios(widget.linha.id);
      setState(() => _horarios = horarios);
    } catch (e) {
      setState(() => _erro = 'Não foi possível carregar os horários.');
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
                  Text(
                    'Linha ${widget.linha.numero}',
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Horários de saída e chegada',
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
                      : ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            // Card com resumo da rota
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _bordaCinza),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.linha.numero} · ${widget.linha.nomeRota}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(widget.linha.origem, style: TextStyle(color: Colors.grey[600])),
                                      const SizedBox(width: 8),
                                      Icon(Icons.arrow_forward, size: 14, color: Colors.grey[500]),
                                      const SizedBox(width: 8),
                                      Text(widget.linha.destino, style: TextStyle(color: Colors.grey[600])),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (_horarios.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 24),
                                child: Text(
                                  'Nenhum horário cadastrado para esta linha.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              )
                            else
                              ..._horarios.map((h) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: _cardHorario(h),
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

  Widget _cardHorario(Horario h) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _bordaCinza),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${h.horarioSaida} → ${h.horarioChegada}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  'Saída · Chegada prevista',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _azulHeader.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _azulHeader.withOpacity(0.4)),
            ),
            child: Text(
              h.diasSemana,
              style: const TextStyle(color: _azulHeader, fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}