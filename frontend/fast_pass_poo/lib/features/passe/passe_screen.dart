import 'package:flutter/material.dart';

import '../../core/sessao_usuario.dart';
import '../../models/passe.dart';
import '../../models/carteirinha.dart';
import '../../services/passe_service.dart';
import '../../services/carteirinha_service.dart';
import '../recarga/recarga_screen.dart';
import '../carteirinha/carteirinha_screen.dart';

class PasseScreen extends StatefulWidget {
  const PasseScreen({super.key});

  @override
  State<PasseScreen> createState() => _PasseScreenState();
}

class _PasseScreenState extends State<PasseScreen> {
  Passe? _passe;
  Carteirinha? _carteirinha;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final usuarioId = SessaoUsuario.usuarioId;

    if (usuarioId == null) {
      setState(() {
        _carregando = false;
      });
      return;
    }

    try {
      final passe =
      await PasseService.buscarPassePorUsuario(usuarioId);

      final carteirinha =
      await CarteirinhaService.buscarPorUsuario(usuarioId);

      if (!mounted) return;

      setState(() {
        _passe = passe;
        _carteirinha = carteirinha;
        _carregando = false;
      });

      SessaoUsuario.passeId = passe.id;
      SessaoUsuario.carteirinhaId = carteirinha?.id;
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _carregando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possível carregar os dados do passe.',
          ),
        ),
      );
    }
  }

  String _nomeTipoPasse() {
    switch (_passe!.tipo) {
      case TipoPasse.COMUM:
        return 'Passe Comum';
      case TipoPasse.ESTUDANTIL:
        return 'Passe Estudantil';
      case TipoPasse.IDOSO:
        return 'Passe Idoso';
    }
  }

  String _tarifa() {
    switch (_passe!.tipo) {
      case TipoPasse.COMUM:
        return 'R\$ 4,50';
      case TipoPasse.ESTUDANTIL:
        return 'R\$ 2,25';
      case TipoPasse.IDOSO:
        return 'Gratuito';
    }
  }

  String _status() {
    switch (_passe!.status) {
      case StatusPasse.ATIVO:
        return 'Ativo';
      case StatusPasse.BLOQUEADO:
        return 'Bloqueado';
      case StatusPasse.VENCIDO:
        return 'Vencido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1466C4),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Passe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _carregando
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _passe == null
          ? const Center(
        child: Text('Passe não encontrado.'),
      )
          : RefreshIndicator(
        onRefresh: _carregarDados,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cartaoPasse(),
              const SizedBox(height: 24),
              _secaoCarteirinha(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cartaoPasse() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD0D7DE),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _nomeTipoPasse(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tarifa: ${_tarifa()}',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Saldo disponível',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'R\$ ${_passe!.saldo.toStringAsFixed(2).replaceAll('.', ',')}',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _linhaInfo(
            'Validade',
            _passe!.validade,
          ),
          const SizedBox(height: 10),
          _linhaInfo(
            'Status',
            _status(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecargaScreen(
                      passeId: _passe!.id,
                    ),
                  ),
                );

                _carregarDados();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F883D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Recarregar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _secaoCarteirinha() {
    if (_carteirinha == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFD0D7DE),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Carteirinha estudantil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Você ainda não possui uma carteirinha estudantil.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CarteirinhaScreen(),
                    ),
                  );

                  _carregarDados();
                },
                child: const Text(
                  'Cadastrar carteirinha',
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD0D7DE),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Carteirinha estudantil',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _linhaInfo(
            'Instituição',
            _carteirinha!.instituicao,
          ),
          const SizedBox(height: 10),
          _linhaInfo(
            'Matrícula',
            _carteirinha!.matricula,
          ),
          const SizedBox(height: 10),
          _linhaInfo(
            'Curso',
            _carteirinha!.curso,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CarteirinhaScreen(),
                  ),
                );
              },
              child: const Text(
                'Ver carteirinha',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _linhaInfo(String titulo, String valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        Flexible(
          child: Text(
            valor,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}