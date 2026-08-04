package com.example.fastpass.model;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.fastpass.model.Carteirinha;
import com.example.fastpass.repository.CarteirinhaRepository;

@SpringBootTest
public class CarteirinhaRepositoryTest {

    @Autowired
    private CarteirinhaRepository carteirinhaRepository;

    @Test
    public void testarCarteirinha() {
        Carteirinha carteirinha = new Carteirinha();
        // Se a sua classe tiver setters (ex: carteirinha.setNumero("123")), coloque aqui
        
        assertThat(carteirinhaRepository).isNotNull();
    }
}