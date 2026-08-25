package com.example.fastpass.controller;

import com.example.fastpass.exception.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler({CredenciaisInvalidasException.class, LoginBloqueadoException.class})
    public ResponseEntity<Map<String, String>> tratarAutenticacaoInvalida(RuntimeException ex) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(erro(ex.getMessage()));
    }

    @ExceptionHandler(ApelidoJaCadastradoException.class)
    public ResponseEntity<Map<String, String>> tratarApelidoDuplicado(ApelidoJaCadastradoException ex) {
        return ResponseEntity.status(HttpStatus.CONFLICT).body(erro(ex.getMessage()));
    }

    // Passe/Carteirinha não encontrados entram no mesmo grupo de 404
    // que Usuario/Linha/Notificacao.
    @ExceptionHandler({UsuarioNaoEncontradoException.class, LinhaNaoEncontradaException.class,
            NotificacaoNaoEncontradaException.class, PasseNaoEncontradoException.class,
            CarteirinhaNaoEncontradaException.class})
    public ResponseEntity<Map<String, String>> tratarNaoEncontrado(RuntimeException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(erro(ex.getMessage()));
    }

    // Passe vencido/inativo, débito com valor/saldo inválido, pagamento de
    // recarga recusado ou valor de recarga inválido -> 400.
    @ExceptionHandler({PasseVencidoException.class, IllegalArgumentException.class,
            PagamentoRecusadoException.class, ValorInvalidoException.class})
    public ResponseEntity<Map<String, String>> tratarErroDeNegocio(RuntimeException ex) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(erro(ex.getMessage()));
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> tratarValidacao(MethodArgumentNotValidException ex) {
        String mensagens = ex.getBindingResult().getFieldErrors().stream()
                .map(erro -> erro.getField() + ": " + erro.getDefaultMessage())
                .reduce((a, b) -> a + "; " + b)
                .orElse("Dados inválidos");
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(erro(mensagens));
    }

    private Map<String, String> erro(String mensagem) {
        Map<String, String> corpo = new HashMap<>();
        corpo.put("erro", mensagem);
        return corpo;
    }
}