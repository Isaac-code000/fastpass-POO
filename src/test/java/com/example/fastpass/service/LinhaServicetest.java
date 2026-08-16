package com.example.fastpass.service;

import com.example.fastpass.exception.LinhaNaoEncontradaException;
import com.example.fastpass.model.Linha;
import com.example.fastpass.repository.LinhaRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;


@ExtendWith(MockitoExtension.class)
class LinhaServiceTest {

    @Mock
    private LinhaRepository linhaRepository;

    @InjectMocks
    private LinhaService linhaService;

    @Test
    void deveLancarExcecaoQuandoLinhaNaoExiste() {
        when(linhaRepository.findById(99L)).thenReturn(Optional.empty());

        assertThrows(LinhaNaoEncontradaException.class, () -> linhaService.buscarPorId(99L));
    }

    @Test
    void deveRetornarLinhaQuandoExiste() {
        Linha linha = new Linha("101", "Centro / Terminal Norte", "Praça da Matriz", "Terminal Norte");
        when(linhaRepository.findById(1L)).thenReturn(Optional.of(linha));

        Linha encontrada = linhaService.buscarPorId(1L);

        assertEquals("101", encontrada.getNumero());
    }
}
