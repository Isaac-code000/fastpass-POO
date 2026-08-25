import 'package:flutter/material.dart';
import 'auth_service.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _apelidoController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _carregando = false;
  String? _erro;

  static const Color _azulHeader = Color(0xFF1466C4);
  static const Color _verdePrimer = Color(0xFF1F883D);
  static const Color _bordaCinza = Color(0xFFD0D7DE);

  Future<void> _cadastrar() async {
    setState(() {
      _carregando = true;
      _erro = null;
    });
    try {
      await AuthService.cadastrar(
        nome: _nomeController.text,
        email: _emailController.text,
        cpf: _cpfController.text,
        apelido: _apelidoController.text,
        senha: _senhaController.text,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      setState(() => _erro = 'Não foi possível cadastrar. Verifique os dados.');
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
            // Cabeçalho azul com botão de voltar
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
                    'Criar conta',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Leva menos de um minuto',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Caixa informativa
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFB3D9F7)),
                      ),
                      child: const Text(
                        'Preencha seus dados para criar o passe digital gratuitamente.',
                        style: TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Card do formulário
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
                          _campoLabel('Nome completo'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _nomeController,
                            decoration: _decoracaoCampo(icone: Icons.person_outline, hint: 'Ana Beatriz Souza'),
                          ),
                          const SizedBox(height: 16),
                          _campoLabel('E-mail'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _decoracaoCampo(icone: Icons.mail_outline, hint: 'ana@email.com'),
                          ),
                          const SizedBox(height: 16),
                          _campoLabel('CPF'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _cpfController,
                            keyboardType: TextInputType.number,
                            decoration: _decoracaoCampo(icone: Icons.badge_outlined, hint: '000.000.000-00'),
                          ),
                          const SizedBox(height: 16),
                          _campoLabel('Apelido'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _apelidoController,
                            decoration: _decoracaoCampo(icone: Icons.person_outline, hint: 'seu.apelido'),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Usado para entrar no aplicativo.',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                          const SizedBox(height: 16),
                          _campoLabel('Senha'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _senhaController,
                            obscureText: true,
                            decoration: _decoracaoCampo(icone: Icons.lock_outline, hint: '••••••••'),
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
                              onPressed: _carregando ? null : _cadastrar,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _verdePrimer,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              icon: _carregando
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                    )
                                  : const Icon(Icons.person_add_alt, size: 18),
                              label: const Text('Cadastrar', style: TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Já tem conta? ', style: TextStyle(color: Colors.grey[700])),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: const Text(
                                    'Entrar',
                                    style: TextStyle(color: _azulHeader, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
    );
  }

  Widget _campoLabel(String texto) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600),
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
