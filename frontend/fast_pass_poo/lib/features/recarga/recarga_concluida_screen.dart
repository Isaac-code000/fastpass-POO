import 'package:flutter/material.dart';
import '../../models/recarga.dart';
import '../home/home_screen.dart';
import '../linhas/linhas_screen.dart';
import '../carteirinha/carteirinha_screen.dart';
import 'recarga_screen.dart';

class RecargaConcluidaScreen extends StatelessWidget {
  final Recarga recarga;

  const RecargaConcluidaScreen({super.key, required this.recarga});

  static const Color _azulHeader = Color(0xFF1466C4);
  static const Color _verdePrimer = Color(0xFF1F883D);
  static const Color _bordaCinza = Color(0xFFD0D7DE);

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
                'Recarga concluída',
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
                      decoration: const BoxDecoration(color: _verdePrimer, shape: BoxShape.circle),
                      child: const Icon(Icons.check, color: Colors.white, size: 34),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recarga concluída',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Recebemos R\$ ${recarga.valor.toStringAsFixed(2).replaceAll('.', ',')} '
                      'e o valor já está disponível no seu passe.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    const SizedBox(height: 24),
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
                          Text(
                            'Novo saldo',
                            style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'R\$ ${recarga.saldoAtual.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _verdePrimer,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: const Icon(Icons.home_outlined, size: 18),
                        label: const Text('Voltar para a Home', style: TextStyle(fontWeight: FontWeight.w600)),
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
            case 1:
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RecargaScreen()));
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