import 'package:flutter/material.dart';
import '../../models/recarga.dart';
import 'recarga_service.dart';
import 'recarga_concluida_screen.dart';
import 'falha_recarga_screen.dart';

/// Representa visualmente o status PENDENTE da Recarga, enquanto
/// aguardamos a confirmação do backend.
class ProcessandoPagamentoScreen extends StatefulWidget {
  final int passeId;
  final double valor;
  final FormaPagamento formaPagamento;

  const ProcessandoPagamentoScreen({
    super.key,
    required this.passeId,
    required this.valor,
    required this.formaPagamento,
  });

  @override
  State<ProcessandoPagamentoScreen> createState() => _ProcessandoPagamentoScreenState();
}

class _ProcessandoPagamentoScreenState extends State<ProcessandoPagamentoScreen> {
  static const Color _azulHeader = Color(0xFF1466C4);

  String get _nomeFormaPagamento => widget.formaPagamento == FormaPagamento.PIX ? 'Pix' : 'Débito';

  @override
  void initState() {
    super.initState();
    _processar();
  }

  Future<void> _processar() async {
    try {
      final recarga = await RecargaService.recarregar(
        passeId: widget.passeId,
        valor: widget.valor,
        formaPagamento: widget.formaPagamento,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => RecargaConcluidaScreen(recarga: recarga)),
      );
    } catch (e) {
      print('ERRO NA RECARGA: $e');
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => FalhaRecargaScreen(
            valor: widget.valor,
            formaPagamento: widget.formaPagamento,
            mensagemDetalhada: 'O pagamento foi recusado pela instituição financeira. '
                'Verifique os dados e tente novamente em alguns instantes.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              color: _azulHeader,
              child: const Text(
                'Pagamento',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 56,
                      height: 56,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.black87,
                        backgroundColor: Color(0xFFE0E0E0),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Processando pagamento...',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'R\$ ${widget.valor.toStringAsFixed(2).replaceAll('.', ',')} via $_nomeFormaPagamento',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Não feche o aplicativo.',
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
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
}