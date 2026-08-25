package com.example.fastpass.controller;

import com.example.fastpass.dto.HorarioResponse;
import com.example.fastpass.dto.LinhaResponse;
import com.example.fastpass.model.Linha;
import com.example.fastpass.service.LinhaService;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/linhas")
    public LinhaResponse criar(@RequestBody Linha linha) {
        return new LinhaResponse(linhaService.salvar(linha));
    }

    @GetMapping("/linhas/{id}/horarios")
    public List<HorarioResponse> listarHorarios(@PathVariable Long id) {
        return linhaService.listarHorarios(id).stream()
                .map(HorarioResponse::new)
                .toList();
    }
}
