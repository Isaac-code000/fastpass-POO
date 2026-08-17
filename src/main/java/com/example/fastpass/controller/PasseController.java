package com.example.fastpass.controller;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.fastpass.dto.PasseRequest;
import com.example.fastpass.dto.PasseResponse;
import com.example.fastpass.facade.PasseFacade;
import com.example.fastpass.model.Passe;
import com.example.fastpass.service.PasseService;

@RestController
@RequestMapping("/api/passes")
public class PasseController {

    @Autowired
    private PasseFacade passeFacade;

    @Autowired
    private PasseService passeService;

    @PostMapping("/validar")
    public ResponseEntity<Boolean> validarUsoDoPasse(@Valid @RequestBody PasseRequest request) {
        boolean liberado = passeFacade.validarUsoDoPasse(request.getPasseId(), request.getCarteirinha());
        return ResponseEntity.ok(liberado);
    }

    @GetMapping("/{id}")
    public ResponseEntity<PasseResponse> buscarPorId(@PathVariable Long id) {
        Passe passe = passeService.consultarPasse(id);
        return ResponseEntity.ok(new PasseResponse(passe));
    }
}