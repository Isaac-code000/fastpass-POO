package com.example.fastpass.controller;

import com.example.fastpass.exception.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

// @RestControllerAdvice = essa classe "escuta" exceções lançadas por
// QUALQUER Controller do projeto, não só o AuthController — é um único
// lugar central pra tratar erro, em vez de cada Controller ter try/catch
// espalhado.
@RestControllerAdvice
public class GlobalExceptionHandler {

    // Credenciais inválidas ou login bloqueado -> 401 Unauthorized.
    // As duas exceções fazem sentido responder igual pro cliente da API,
    // por segurança (não expõe qual dos dois motivos foi).
    @ExceptionHandler({CredenciaisInvalidasException.class, LoginBloqueadoException.class})
    public ResponseEntity<Map<String, String>> tratarAutenticacaoInvalida(RuntimeException ex) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(erro(ex.getMessage()));
    }

    // Apelido já cadastrado -> 409 Conflict (o código HTTP específico
    // pra "esse recurso já existe, não posso criar de novo").
    @ExceptionHandler(ApelidoJaCadastradoException.class)
    public ResponseEntity<Map<String, String>> tratarApelidoDuplicado(ApelidoJaCadastradoException ex) {
        return ResponseEntity.status(HttpStatus.CONFLICT).body(erro(ex.getMessage()));
    }

    // Usuário/Linha/Notificação não encontrados -> 404 Not Found.
    @ExceptionHandler({UsuarioNaoEncontradoException.class, LinhaNaoEncontradaException.class,
            NotificacaoNaoEncontradaException.class})
    public ResponseEntity<Map<String, String>> tratarNaoEncontrado(RuntimeException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(erro(ex.getMessage()));
    }

    // Erros de @Valid (campos em branco, e-mail inválido, etc.) caem
    // aqui automaticamente — o Spring já lança MethodArgumentNotValidException
    // sozinho antes do Controller rodar, a gente só formata a resposta.
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> tratarValidacao(MethodArgumentNotValidException ex) {
        String mensagens = ex.getBindingResult().getFieldErrors().stream()
                .map(erro -> erro.getField() + ": " + erro.getDefaultMessage())
                .reduce((a, b) -> a + "; " + b)
                .orElse("Dados inválidos");
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(erro(mensagens));
    }

    // Método auxiliar só pra não repetir "new HashMap...put(erro,...)"
    // em cada handler acima.
    private Map<String, String> erro(String mensagem) {
        Map<String, String> corpo = new HashMap<>();
        corpo.put("erro", mensagem);
        return corpo;
    }
}
