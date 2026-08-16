package com.example.fastpass.service;

import com.example.fastpass.exception.LinhaNaoEncontradaException;
import com.example.fastpass.model.Horario;
import com.example.fastpass.model.Linha;
import com.example.fastpass.repository.LinhaRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;


@SpringBootTest
@ActiveProfiles("test")
@Transactional
class LinhaServiceIntegrationTest {

    @Autowired
    private LinhaService linhaService;

    @Autowired
    private LinhaRepository linhaRepository;

    @Test
    void deveListarHorariosDeUmaLinhaSalva() {
        Linha linha = new Linha("208", "Circular Universidade", "Terminal Central", "Campus Universitário");
        linha.adicionarHorario(new Horario(LocalTime.of(6, 0), LocalTime.of(6, 35), "Seg a Sex"));
        Linha salva = linhaRepository.save(linha);

        List<Horario> horarios = linhaService.listarHorarios(salva.getId());

        assertEquals(1, horarios.size());
        assertEquals("Seg a Sex", horarios.get(0).getDiasSemana());
    }

    @Test
    void deveLancarExcecaoParaLinhaInexistente() {
        assertThrows(LinhaNaoEncontradaException.class, () -> linhaService.buscarPorId(999L));
    }
}