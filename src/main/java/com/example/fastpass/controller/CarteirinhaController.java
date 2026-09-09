package com.example.fastpass.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.fastpass.dto.CarteirinhaResponse;
import com.example.fastpass.model.Carteirinha;
import com.example.fastpass.model.Usuario;
import com.example.fastpass.service.CarteirinhaService;
import com.example.fastpass.service.UsuarioService;
import com.example.fastpass.dto.CarteirinhaRequest;
import org.springframework.http.HttpStatus;
import com.example.fastpass.service.PasseService;
import com.example.fastpass.model.Passe;
import com.example.fastpass.model.TipoPasse;
import java.time.LocalDate;

@RestController
@RequestMapping("/carteirinhas")
public class CarteirinhaController {

    @Autowired
    private CarteirinhaService carteirinhaService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private PasseService passeService;

    @GetMapping("/{id}")
    public ResponseEntity<CarteirinhaResponse> buscarPorId(@PathVariable Long id) {
        Carteirinha carteirinha = carteirinhaService.consultarPorId(id);
        return ResponseEntity.ok(new CarteirinhaResponse(carteirinha));
    }

    // Se o usuário não tiver carteirinha, isso lança CarteirinhaNaoEncontradaException,
    // que o GlobalExceptionHandler converte em 404 — o Flutter trata esse
    // 404 como "sem carteirinha estudantil", não como erro grave.
    @GetMapping("/usuario/{usuarioId}")
    public ResponseEntity<CarteirinhaResponse> buscarPorUsuario(@PathVariable Long usuarioId) {
        Usuario usuario = usuarioService.buscarPorId(usuarioId);
        Carteirinha carteirinha = carteirinhaService.consultarPorUsuario(usuario);
        return ResponseEntity.ok(new CarteirinhaResponse(carteirinha));
    }

    @PostMapping
    public ResponseEntity<CarteirinhaResponse> cadastrar(
            @RequestBody CarteirinhaRequest request) {

        Usuario usuario = usuarioService.buscarPorId(request.usuarioId());

        LocalDate validade = LocalDate.now().plusYears(1);

        Carteirinha carteirinha = new Carteirinha(
                request.matricula(),
                request.instituicao(),
                request.curso(),
                validade,
                usuario
        );

        carteirinha = carteirinhaService.salvar(carteirinha);

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(new CarteirinhaResponse(carteirinha));
    }}