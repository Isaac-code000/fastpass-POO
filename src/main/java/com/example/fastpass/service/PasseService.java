package com.example.fastpass.service;

import org.springframework.stereotype.Service;
import com.example.fastpass.model.Passe;
import com.example.fastpass.repository.PasseRepository;
import com.example.fastpass.exception.PasseNaoEncontradoException;
import com.example.fastpass.exception.PasseVencidoException;

@Service
public class PasseService {

    private final PasseRepository passeRepository;

    public PasseService(PasseRepository passeRepository) {
        this.passeRepository = passeRepository;
    }

    public Passe consultarPasse(Long id) {
        return passeRepository.findById(id)
                .orElseThrow(() -> new PasseNaoEncontradoException("Passe não encontrado com o ID: " + id));
    }

    public Passe debitarSaldo(Long id, double valor) {
        Passe passe = consultarPasse(id);

        // Verifica se o passe está válido (ativo e dentro da validade)
        if (!passe.validar()) {
            throw new PasseVencidoException("Não foi possível debitar: o passe está inativo ou vencido.");
        }

        // Tenta debitar usando o próprio método da entidade Passe
        boolean debitoComSucesso = passe.debitar(valor);
        if (!debitoComSucesso) {
            throw new IllegalArgumentException("Saldo insuficiente ou valor inválido para débito.");
        }

        // Salva e retorna o passe atualizado no banco de dados
        return passeRepository.save(passe);
    }

    public boolean validarSePodeRecarregar(Passe passe) {
        if (passe == null) {
            return false;
        }
        // Só permite recarregar se o passe estiver válido
        return passe.validar();
    }
}