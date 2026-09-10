package com.example.fastpass.service;

import com.example.fastpass.exception.HistoricoNaoEncontradoException;
import com.example.fastpass.model.HistoricoUso;
import com.example.fastpass.repository.HistoricoUsoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HistoricoUsoService {

    @Autowired
    private HistoricoUsoRepository historicoUsoRepository;

    public HistoricoUso registrarUso(HistoricoUso historico) {
        return historicoUsoRepository.save(historico);
    }

    public List<HistoricoUso> listarHistorico() {
        return historicoUsoRepository.findAll();
    }

    public HistoricoUso buscarPorId(Long id) {
        return historicoUsoRepository.findById(id)
                .orElseThrow(() -> new HistoricoNaoEncontradoException("Histórico de uso não encontrado para o ID: " + id));
    }
}