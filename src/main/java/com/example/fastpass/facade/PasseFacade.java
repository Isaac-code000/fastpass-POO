package com.example.fastpass.facade;

import org.springframework.stereotype.Component;
import com.example.fastpass.model.Passe;
import com.example.fastpass.model.Carteirinha;
import com.example.fastpass.model.TipoPasse;
import com.example.fastpass.service.PasseService;
import com.example.fastpass.service.CarteirinhaService;
import com.example.fastpass.exception.CarteirinhaInvalidaException;

@Component
public class PasseFacade {

    private final PasseService passeService;
    private final CarteirinhaService carteirinhaService;

    public PasseFacade(PasseService passeService, CarteirinhaService carteirinhaService) {
        this.passeService = passeService;
        this.carteirinhaService = carteirinhaService;
    }

    
     
    public boolean validarUsoDoPasse(Long passeId, Carteirinha carteirinha) {
        Passe passe = passeService.consultarPasse(passeId);

        
        if (TipoPasse.ESTUDANTIL.equals(passe.getTipo())) {
            if (carteirinha == null || !carteirinhaService.isValidaParaTarifaEstudantil(carteirinha)) {
                throw new CarteirinhaInvalidaException("Uso negado: Carteirinha estudantil inválida ou inexistente.");
            }
        }

        
        return passe.validar();
    }

   
    public Passe utilizarPasse(Long passeId, double valor, Carteirinha carteirinha) {
       
        validarUsoDoPasse(passeId, carteirinha);

        
        return passeService.debitarSaldo(passeId, valor);
    }
}