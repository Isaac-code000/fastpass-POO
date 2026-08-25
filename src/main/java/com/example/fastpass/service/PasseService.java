package com.example.fastpass.service;

import org.springframework.stereotype.Service;
import com.example.fastpass.model.Passe;
import com.example.fastpass.model.Usuario;
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

    // Usado pela Home do app logo após o login, pra descobrir o passe
    // do usuário autenticado sem precisar adivinhar o id dele.
    public Passe consultarPassePorUsuario(Usuario usuario) {
        return passeRepository.findByUsuario(usuario)
                .orElseThrow(() -> new PasseNaoEncontradoException("Usuário ainda não possui passe cadastrado."));
    }

    public Passe debitarSaldo(Long id, double valor) {
        Passe passe = consultarPasse(id);

        if (!passe.validar()) {
            throw new PasseVencidoException("Não foi possível debitar: o passe está inativo ou vencido.");
        }

        boolean debitoComSucesso = passe.debitar(valor);
        if (!debitoComSucesso) {
            throw new IllegalArgumentException("Saldo insuficiente ou valor inválido para débito.");
        }

        return passeRepository.save(passe);
    }

    public boolean validarSePodeRecarregar(Passe passe) {
        if (passe == null) {
            return false;
        }
        return passe.validar();
    }
}