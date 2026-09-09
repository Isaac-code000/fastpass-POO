import 'package:flutter/material.dart';
import '../../models/recarga.dart';
import '../../core/sessao_usuario.dart';
import '../../shared/loading_indicator.dart';
import 'processando_pagamento_screen.dart';
import '../home/home_screen.dart';
import '../linhas/linhas_screen.dart';
import '../carteirinha/carteirinha_screen.dart';

class RecargaScreen extends StatefulWidget {
  // Agora OPCIONAL — quando não vier (ex: menu de dev, bottom nav de
  // outras telas), a própria tela busca o passeId de SessaoUsuario.
  final int? passeId;

  const RecargaScreen({super.key, this.passeId});

  @override
  State<RecargaScreen> createState() => _RecargaScreenState();
}

class _RecargaScreenState extends State<RecargaScreen> {
  final _valorController = TextEditingController();
  FormaPagamento _formaPagamento = FormaPagamento.PIX;

  static const Color _azulHeader = Color(0xFF1466C4);
  static const Color _verdePrimer = Color(0xFF1F883D);
  static const Color _bordaCinza = Color(0xFFD0D7DE);

  int? _passeIdResolvido;

  @override
  void initState() {
    super.initState();
    // Prioridade: parâmetro recebido > sessão salva pela Home > nada (erro)
    _passeIdResolvido = widget.passeId ?? SessaoUsuario.passeId;
  }

  void _confirmar() {
    final valor = double.tryParse(_valorController.text.replaceAll(',', '.'));
    if (valor == null || valor <= 0) return;
    if (_passeIdResolvido == null) return; // botão nem aparece nesse caso, ver build()

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProcessandoPagamentoScreen(
          passeId: _passeIdResolvido!,
          valor: valor,
          formaPagamento: _formaPagamento,
        ),
      ),
    );
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
                  const Text('Recarregar Passe', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  const Text('Adicione saldo ao seu passe', style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            Expanded(
              child: _passeIdResolvido == null
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Não foi possível identificar seu passe.\nVolte para a Home e tente novamente.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                              (route) => false,
                        ),
                        child: const Text('Voltar para a Home'),
                      ),
                    ],
                  ),
                ),
              )
                  : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Container(
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
                      const Text('Valor', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _valorController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('R\$', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
                          ),
                          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                          hintText: '0,00',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: _bordaCinza)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: _bordaCinza)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: _azulHeader, width: 1.5)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Forma de pagamento', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      const SizedBox(height: 10),
                      _opcaoPagamento(forma: FormaPagamento.PIX, icone: Icons.pix, titulo: 'Pix', subtitulo: 'Confirmação instantânea'),
                      const SizedBox(height: 10),
                      _opcaoPagamento(forma: FormaPagamento.DEBITO, icone: Icons.credit_card, titulo: 'Débito', subtitulo: 'Débito em conta'),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _confirmar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _verdePrimer,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Confirmar Recarga', style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
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
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
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

  Widget _opcaoPagamento({required FormaPagamento forma, required IconData icone, required String titulo, required String subtitulo}) {
    final selecionado = _formaPagamento == forma;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => setState(() => _formaPagamento = forma),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selecionado ? _azulHeader.withOpacity(0.06) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: selecionado ? _azulHeader : _bordaCinza, width: selecionado ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Icon(icone, color: selecionado ? _azulHeader : Colors.grey[600], size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text(subtitulo, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            Icon(selecionado ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: selecionado ? _azulHeader : Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }
}