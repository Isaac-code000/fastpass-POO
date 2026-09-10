package com.example.fastpass.facade;

import com.example.fastpass.model.HistoricoUso;
import com.example.fastpass.service.HistoricoUsoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class FastPassFacade {

    @Autowired
    private HistoricoUsoService historicoUsoService;

    public HistoricoUso registrarHistoricoUso(HistoricoUso historico) {
        return historicoUsoService.registrarUso(historico);
    }

    public List<HistoricoUso> listarHistoricosUso() {
        return historicoUsoService.listarHistorico();
    }

    public HistoricoUso buscarHistoricoUsoPorId(Long id) {
        return historicoUsoService.buscarPorId(id);
    }
}