package com.example.fastpass.service;

import org.springframework.stereotype.Service;
import com.example.fastpass.model.Carteirinha;
import com.example.fastpass.repository.CarteirinhaRepository;
import com.example.fastpass.exception.CarteirinhaInvalidaException;

@Service
public class CarteirinhaService {

    private final CarteirinhaRepository carteirinhaRepository;

    public CarteirinhaService(CarteirinhaRepository carteirinhaRepository) {
        this.carteirinhaRepository = carteirinhaRepository;
    }

    public Carteirinha buscarPorId(Long id) {
        return carteirinhaRepository.findById(id)
                .orElseThrow(() -> new CarteirinhaInvalidaException("Carteirinha não encontrada com o ID: " + id));
    }

    public boolean isValidaParaTarifaEstudantil(Carteirinha carteirinha) {
        if (carteirinha == null) {
            return false;
        }
        // Usa o método validar() que você já criou na classe Carteirinha!
        return carteirinha.validar();
    }
}