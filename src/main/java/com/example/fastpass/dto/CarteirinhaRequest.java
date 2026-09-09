package com.example.fastpass.dto;

public record CarteirinhaRequest(
        String matricula,
        String instituicao,
        String curso,
        Long usuarioId
) {}
