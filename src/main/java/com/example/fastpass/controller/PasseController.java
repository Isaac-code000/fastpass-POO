package com.example.fastpass.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.fastpass.dto.PasseResponse;
import com.example.fastpass.model.Passe;
import com.example.fastpass.model.Usuario;
import com.example.fastpass.service.PasseService;
import com.example.fastpass.service.UsuarioService;

@RestController
@RequestMapping("/passes")
public class PasseController {

    @Autowired
    private PasseService passeService;

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/{id}")
    public ResponseEntity<PasseResponse> buscarPorId(@PathVariable Long id) {
        Passe passe = passeService.consultarPasse(id);
        return ResponseEntity.ok(new PasseResponse(passe));
    }

    // Endpoint que o app Flutter chama logo após o login, pra descobrir
    // qual é o passe do usuário autenticado.
    @GetMapping("/usuario/{usuarioId}")
    public ResponseEntity<PasseResponse> buscarPorUsuario(@PathVariable Long usuarioId) {
        Usuario usuario = usuarioService.buscarPorId(usuarioId);
        Passe passe = passeService.consultarPassePorUsuario(usuario);
        return ResponseEntity.ok(new PasseResponse(passe));
    }
    @PostMapping("/{id}/utilizar")
    public ResponseEntity<PasseResponse> utilizar(@PathVariable Long id) {
        Passe passe = passeService.utilizarPasse(id);

        return ResponseEntity.ok(new PasseResponse(passe));
    }
}