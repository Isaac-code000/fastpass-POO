import 'package:flutter/material.dart';

/// Mensagem de erro padrão do app, com botão opcional de "tentar novamente".
class ErrorMessage extends StatelessWidget {
  final String mensagem;
  final VoidCallback? onTentarNovamente;

  const ErrorMessage({super.key, required this.mensagem, this.onTentarNovamente});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onTentarNovamente != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onTentarNovamente,
                child: const Text('Tentar novamente'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
