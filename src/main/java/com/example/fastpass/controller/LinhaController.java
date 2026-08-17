package com.example.fastpass.controller;

import com.example.fastpass.dto.HorarioResponse;
import com.example.fastpass.dto.LinhaResponse;
import com.example.fastpass.service.LinhaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class LinhaController {

    private final LinhaService linhaService;

    public LinhaController(LinhaService linhaService) {
        this.linhaService = linhaService;
    }

    // Bate com GET /linhas do contrato de API.
    @GetMapping("/linhas")
    public List<LinhaResponse> listarLinhas() {
        return linhaService.listarTodas().stream()
                .map(LinhaResponse::new)
                .toList();
    }

    // Bate com GET /linhas/{id}/horarios do contrato de API.
    // Se o id não existir, LinhaService já lança LinhaNaoEncontradaException,
    // que o GlobalExceptionHandler transforma em 404 automaticamente —
    // não precisa tratar erro aqui dentro do Controller.
    @GetMapping("/linhas/{id}/horarios")
    public List<HorarioResponse> listarHorarios(@PathVariable Long id) {
        return linhaService.listarHorarios(id).stream()
                .map(HorarioResponse::new)
                .toList();
    }
}
