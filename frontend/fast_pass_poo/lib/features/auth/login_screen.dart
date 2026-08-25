import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'cadastro_screen.dart';
import '../home/home_screen.dart';
import '../dev/dev_menu_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _apelidoController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _carregando = false;
  String? _erro;

  // Cores extraídas do mockup (estilo Primer/GitHub)
  static const Color _azulHeader = Color(0xFF1466C4);
  static const Color _verdePrimer = Color(0xFF1F883D);

  Future<void> _entrar() async {
    setState(() {
      _carregando = true;
      _erro = null;
    });
    try {
      await AuthService.login(_apelidoController.text, _senhaController.text);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      setState(() => _erro = 'Credenciais inválidas. Tente novamente.');
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: Column(
          children: [
            // Cabeçalho azul
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              color: _azulHeader,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Entrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Acesse seu passe digital',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    // Ícone circular com a logo
                    Container(
                      width: 80,
                      height: 80,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(color:Colors.white, shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/icons/one.png',
                        fit: BoxFit.contain,
                        
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.inventory_2_outlined, color: Colors.white, size: 36);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'FastPass',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Entre para acessar seu passe',
                      style: TextStyle(color: Colors.grey[600], fontSize: 15),
                    ),
                    const SizedBox(height: 24),

                    // Card do formulário
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFD0D7DE)),
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
                          _campoLabel('Apelido'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _apelidoController,
                            decoration: _decoracaoCampo(
                              icone: Icons.person_outline,
                              hint: 'anabeatriz',
                            ),
                          ),
                          const SizedBox(height: 16),
                          _campoLabel('Senha'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _senhaController,
                            obscureText: true,
                            decoration: _decoracaoCampo(
                              icone: Icons.lock_outline,
                              hint: '••••••••',
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Mínimo de 6 caracteres.',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                          if (_erro != null) ...[
                            const SizedBox(height: 12),
                            Text(_erro!, style: const TextStyle(color: Colors.red)),
                          ],
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: _carregando ? null : _entrar,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _verdePrimer,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              icon: _carregando
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.login, size: 18),
                              label: const Text(
                                'Entrar',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ainda não tem conta? ', style: TextStyle(color: Colors.grey[700])),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const CadastroScreen()),
                          ),
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(
                              color: _azulHeader,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // remover antes da entrega — botão pra ver se as telas ficaram massa
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const DevMenuScreen()),
                      ),
                      child: const Text('[DEV] Ir para menu de telas'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campoLabel(String texto) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(text: texto),
          const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  InputDecoration _decoracaoCampo({required IconData icone, required String hint}) {
    return InputDecoration(
      prefixIcon: Icon(icone, color: Colors.grey[500], size: 20),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD0D7DE)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD0D7DE)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _azulHeader, width: 1.5),
      ),
    );
  }
}