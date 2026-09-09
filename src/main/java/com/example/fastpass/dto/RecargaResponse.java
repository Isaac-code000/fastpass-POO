package com.example.fastpass.dto;

import com.example.fastpass.model.Recarga;
import com.example.fastpass.model.StatusRecarga;

public record RecargaResponse(
        Long id,
        double valor,
        String data,
        StatusRecarga status,
        Long pagamentoId,
        double saldoAtual
) {
    public static RecargaResponse of(Recarga recarga) {
        return new RecargaResponse(
                recarga.getId(),
                recarga.getValor(),
                recarga.getData().toString(),
                recarga.getStatus(),
                recarga.getPagamento() != null ? recarga.getPagamento().getId() : null,
                recarga.getPasse() != null ? recarga.getPasse().getSaldo() : 0.0
        );
    }
}
