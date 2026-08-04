package com.example.fastpass.model;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import com.example.fastpass.repository.PasseRepository;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class PasseRepositoryTest {

    @Autowired
    private PasseRepository passeRepository;

    @Test
    public void testarPasse() {
        Passe passe = new Passe();

        Passe passeSalvo = passeRepository.save(passe);

        assertThat(passeSalvo).isNotNull();
        assertThat(passeRepository).isNotNull();
    }
}