package com.example.fastpass.dto;

import jakarta.validation.constraints.NotNull;
import com.example.fastpass.model.Carteirinha;

public class PasseRequest {

    @NotNull(message = "O ID do passe é obrigatório")
    private Long passeId;

    private Carteirinha carteirinha; // Pode ser null se for passe COMUM

    public PasseRequest() {}

    public PasseRequest(Long passeId, Carteirinha carteirinha) {
        this.passeId = passeId;
        this.carteirinha = carteirinha;
    }

    public Long getPasseId() {
        return passeId;
    }

    public void setPasseId(Long passeId) {
        this.passeId = passeId;
    }

    public Carteirinha getCarteirinha() {
        return carteirinha;
    }

    public void setCarteirinha(Carteirinha carteirinha) {
        this.carteirinha = carteirinha;
    }
}