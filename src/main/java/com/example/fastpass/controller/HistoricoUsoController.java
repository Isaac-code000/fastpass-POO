package com.example.fastpass.controller;

import com.example.fastpass.facade.FastPassFacade;
import com.example.fastpass.model.HistoricoUso;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/historico-uso")
public class HistoricoUsoController {

    @Autowired
    private FastPassFacade fastPassFacade;

    @PostMapping
    public ResponseEntity<HistoricoUso> registrar(@RequestBody HistoricoUso historico) {
        return ResponseEntity.ok(fastPassFacade.registrarHistoricoUso(historico));
    }

    @GetMapping
    public ResponseEntity<List<HistoricoUso>> listar() {
        return ResponseEntity.ok(fastPassFacade.listarHistoricosUso());
    }

    @GetMapping("/{id}")
    public ResponseEntity<HistoricoUso> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(fastPassFacade.buscarHistoricoUsoPorId(id));
    }
}