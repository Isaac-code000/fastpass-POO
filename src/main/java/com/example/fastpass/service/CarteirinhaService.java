package com.example.fastpass.service;

import org.springframework.stereotype.Service;
import com.example.fastpass.model.Carteirinha;
import com.example.fastpass.model.Usuario;
import com.example.fastpass.repository.CarteirinhaRepository;
import com.example.fastpass.exception.CarteirinhaNaoEncontradaException;

@Service
public class CarteirinhaService {

    private final CarteirinhaRepository carteirinhaRepository;

    public CarteirinhaService(CarteirinhaRepository carteirinhaRepository) {
        this.carteirinhaRepository = carteirinhaRepository;
    }

    public Carteirinha consultarPorId(Long id) {
        return carteirinhaRepository.findById(id)
                .orElseThrow(() -> new CarteirinhaNaoEncontradaException("Carteirinha não encontrada com o ID: " + id));
    }

    public Carteirinha consultarPorUsuario(Usuario usuario) {
        return carteirinhaRepository.findByUsuario(usuario)
                .orElseThrow(() -> new CarteirinhaNaoEncontradaException("Usuário não possui carteirinha estudantil cadastrada."));
    }

    public boolean validarParaTarifaEstudantil(Carteirinha carteirinha) {
        return carteirinha != null && carteirinha.validar();
    }
}