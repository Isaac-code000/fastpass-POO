import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

/// Tela exibida ao abrir o app, enquanto verificamos se o usuário
/// já está logado (TODO: checar token/sessão salva antes de navegar).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Color _azulHeader = Color(0xFF1466C4);

  @override
  void initState() {
    super.initState();
    _iniciar();
  }

  Future<void> _iniciar() async {
    await Future.delayed(const Duration(seconds: 2));
    // TODO: verificar se já existe sessão salva; se sim, ir direto pra HomeScreen.
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _azulHeader,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              // Imagem da logo — se o arquivo tiver outro nome/caminho, ajusta aqui.
              padding: const EdgeInsets.all(18),
              child: Image.asset(
                'assets/icons/one.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback caso o asset não seja encontrado, para não quebrar o app.
                  return const Icon(Icons.inventory_2_outlined, color: _azulHeader, size: 44);
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'FastPass',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Seu passe de ônibus digital',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 32),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
            ),
            const SizedBox(height: 12),
            const Text(
              'Carregando...',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
  
