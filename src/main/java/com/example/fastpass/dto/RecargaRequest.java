package com.example.fastpass.dto;

import com.example.fastpass.model.FormaPagamento;


public record RecargaRequest(
        Long passeId,
        double valor,
        FormaPagamento formaPagamento,
        String chavePix,
        Double desconto
) {}
