package com.example.fastpass.controller;

import com.example.fastpass.dto.CadastroUsuarioRequest;
import com.example.fastpass.dto.LoginRequest;
import com.example.fastpass.dto.LoginResponse;
import com.example.fastpass.dto.UsuarioResponse;
import com.example.fastpass.facade.AuthFacade;
import com.example.fastpass.model.Usuario;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

// @RestController = @Controller + @ResponseBody: todo retorno de método
// vira JSON automaticamente, sem precisar escrever nada a mais pra isso.
@RestController
public class AuthController {

    private final AuthFacade authFacade;

    // Repare: o Controller só conhece a Fachada — não sabe nada sobre
    // UsuarioService, LoginRepository, etc. Toda a orquestração já
    // aconteceu nas camadas de baixo.
    public AuthController(AuthFacade authFacade) {
        this.authFacade = authFacade;
    }

    // Bate com o endpoint POST /auth/login do contrato de API.
    @PostMapping("/auth/login")
    public ResponseEntity<LoginResponse> login(@Valid @RequestBody LoginRequest request) {
        // @Valid dispara a Validation dos campos do LoginRequest ANTES
        // do corpo do método rodar — se algo estiver em branco, o Spring
        // já responde 400 sozinho, sem essa linha nem ser alcançada.
        Usuario usuario = authFacade.autenticar(request.getApelido(), request.getSenha());
        return ResponseEntity.ok(new LoginResponse(usuario));
    }

    // Bate com o endpoint POST /usuarios do contrato de API.
    @PostMapping("/usuarios")
    public ResponseEntity<UsuarioResponse> cadastrar(@Valid @RequestBody CadastroUsuarioRequest request) {
        Usuario usuario = authFacade.cadastrar(
                request.getNome(),
                request.getEmail(),
                request.getCpf(),
                request.getApelido(),
                request.getSenha()
        );
        // 201 Created é o status HTTP correto pra "criei um recurso novo"
        // — diferente do 200 do login, que só consulta/confirma algo já existente.
        return ResponseEntity.status(HttpStatus.CREATED).body(new UsuarioResponse(usuario));
    }
}
