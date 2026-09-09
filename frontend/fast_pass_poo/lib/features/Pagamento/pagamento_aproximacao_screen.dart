import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/sessao_usuario.dart';
import '../../services/passe_service.dart';
import 'pagamento_concluido_screen.dart';

class PagamentoAproximacaoScreen extends StatefulWidget {
  const PagamentoAproximacaoScreen({super.key});

  @override
  State<PagamentoAproximacaoScreen> createState() =>
      _PagamentoAproximacaoScreenState();
}

class _PagamentoAproximacaoScreenState
    extends State<PagamentoAproximacaoScreen> {
  bool _processando = true;
  String _mensagem = 'Aproxime seu passe da catraca';

  @override
  void initState() {
    super.initState();
    _processarPagamento();
  }

  Future<void> _processarPagamento() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    setState(() {
      _mensagem = 'Passe identificado!';
    });

    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    final passeId = SessaoUsuario.passeId;

    if (passeId == null) {
      setState(() {
        _processando = false;
        _mensagem = 'Passe não encontrado.';
      });
      return;
    }

    try {
      final passe = await PasseService.utilizarPasse(passeId);

      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => PagamentoConcluidoScreen(
            passe: passe,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _processando = false;
        _mensagem = 'Não foi possível realizar o pagamento.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento por aproximação'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.contactless,
                  size: 90,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 40),

              Text(
                _mensagem,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              if (_processando) ...[
                const Text(
                  'Aguarde enquanto identificamos seu passe...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                const CircularProgressIndicator(),
              ],

              if (!_processando) ...[
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Voltar'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}