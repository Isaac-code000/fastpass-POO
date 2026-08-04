package com.example.fastpass.model;

import com.example.fastpass.repository.HorarioRepository;
import com.example.fastpass.repository.LinhaRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.time.LocalTime;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
class LinhaRepositoryTest {

    @Autowired
    private LinhaRepository linhaRepository;

    @Autowired
    private HorarioRepository horarioRepository;

    @Test
    void deveSalvarEBuscarLinha() {
        Linha linha = new Linha("101", "Centro / Terminal Norte", "Praça da Matriz", "Terminal Norte");

        Linha salva = linhaRepository.save(linha);

        assertNotNull(salva.getId(), "O ID deveria ter sido gerado pelo banco");

        Optional<Linha> encontrada = linhaRepository.findById(salva.getId());
        assertTrue(encontrada.isPresent());
        assertEquals("101", encontrada.get().getNumero());
        assertEquals("Centro / Terminal Norte", encontrada.get().getNomeRota());
    }

    @Test
    void deveSalvarHorarioAssociadoALinha() {
        Linha linha = linhaRepository.save(
                new Linha("208", "Circular Universidade", "Terminal Central", "Campus Universitário"));

        Horario horario = new Horario(LocalTime.of(6, 0), LocalTime.of(6, 35), "Seg a Sex");
        linha.adicionarHorario(horario);
        horarioRepository.save(horario);

        Optional<Horario> encontrado = horarioRepository.findById(horario.getId());
        assertTrue(encontrado.isPresent());
        assertEquals(linha.getId(), encontrado.get().getLinha().getId());
        assertEquals("Seg a Sex", encontrado.get().getDiasSemana());
    }
}
