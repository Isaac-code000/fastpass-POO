import 'package:flutter/material.dart';
import '../../models/recarga.dart';
import '../home/home_screen.dart';
import '../linhas/linhas_screen.dart';
import '../carteirinha/carteirinha_screen.dart';
import 'recarga_screen.dart';

class FalhaRecargaScreen extends StatelessWidget {
  final double valor;
  final FormaPagamento formaPagamento;
  final String mensagemDetalhada;

  const FalhaRecargaScreen({
    super.key,
    required this.valor,
    required this.formaPagamento,
    required this.mensagemDetalhada,
  });

  static const Color _azulHeader = Color(0xFF1466C4);
  static const Color _verdePrimer = Color(0xFF1F883D);
  static const Color _bordaCinza = Color(0xFFD0D7DE);

  String get _nomeFormaPagamento => formaPagamento == FormaPagamento.PIX ? 'Pix' : 'Débito';

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
              child: const Text(
                'Recarga não concluída',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(color: Color(0xFFC62828), shape: BoxShape.circle),
                      child: const Icon(Icons.close, color: Colors.white, size: 32),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Falha na recarga',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Não conseguimos processar R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')} via $_nomeFormaPagamento. Nenhum valor foi cobrado.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDECEA),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFF5C6C0)),
                      ),
                      child: Text(
                        mensagemDetalhada,
                        style: const TextStyle(color: Color(0xFF5A1A15), fontSize: 14, height: 1.4),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const RecargaScreen()),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _verdePrimer,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text('Tentar novamente', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: _bordaCinza),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: const Icon(Icons.home_outlined, size: 18, color: Colors.black87),
                        label: const Text(
                          'Voltar para a Home',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
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
        currentIndex: 1,
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
            case 2:
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LinhasScreen()));
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
}