import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import '../auth/cadastro_screen.dart';
import '../auth/erro_login_screen.dart';
import '../home/home_screen.dart';
import '../recarga/recarga_screen.dart';
import '../recarga/recarga_concluida_screen.dart';
import '../recarga/falha_recarga_screen.dart';
import '../linhas/linhas_screen.dart';
import '../carteirinha/carteirinha_screen.dart';
import '../../models/recarga.dart';


class DevMenuScreen extends StatelessWidget {
  const DevMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final telas = <String, WidgetBuilder>{
      'Login': (_) => const LoginScreen(),
      'Cadastro': (_) => const CadastroScreen(),
      'Erro de Login': (_) => const ErroLoginScreen(),
      'Home': (_) => const HomeScreen(),
      'Recarga': (_) => const RecargaScreen(),
      'Recarga Concluída (exemplo)': (_) => RecargaConcluidaScreen(
            recarga: Recarga(
              id: 1,
              valor: 20,
              data: '2026-08-02',
              status: StatusRecarga.CONFIRMADA,
              saldoAtual: 45.50,
            ),
          ),
      'Falha na Recarga (exemplo)': (_) => const FalhaRecargaScreen(
            valor: 0,
            formaPagamento: FormaPagamento.PIX,
            mensagemDetalhada:
                'O pagamento foi recusado pela instituição financeira. '
                'Verifique os dados e tente novamente em alguns instantes.',
          ),
      'Linhas': (_) => const LinhasScreen(),
      'Minha Carteirinha': (_) => const CarteirinhaScreen(),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Menu de desenvolvimento')),
      body: ListView(
        children: telas.entries.map((entrada) {
          return ListTile(
            title: Text(entrada.key),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: entrada.value),
            ),
          );
        }).toList(),
      ),
    );
  }
}