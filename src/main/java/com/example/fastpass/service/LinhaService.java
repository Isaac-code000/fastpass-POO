package com.example.fastpass.service;

import com.example.fastpass.exception.LinhaNaoEncontradaException;
import com.example.fastpass.model.Horario;
import com.example.fastpass.model.Linha;
import com.example.fastpass.repository.LinhaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LinhaService {

    private final LinhaRepository linhaRepository;

    public LinhaService(LinhaRepository linhaRepository) {
        this.linhaRepository = linhaRepository;
    }

    public List<Linha> listarTodas() {
        return linhaRepository.findAll();
    }

    public Linha buscarPorId(Long id) {
        return linhaRepository.findById(id)
                .orElseThrow(() -> new LinhaNaoEncontradaException(id));
    }

    public List<Horario> listarHorarios(Long linhaId) {
        Linha linha = buscarPorId(linhaId);
        return linha.getHorarios();
    }
}
