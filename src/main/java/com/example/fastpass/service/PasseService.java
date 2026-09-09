package com.example.fastpass.service;

import com.example.fastpass.model.Carteirinha;
import org.springframework.stereotype.Service;
import com.example.fastpass.model.Passe;
import com.example.fastpass.model.Usuario;
import com.example.fastpass.repository.PasseRepository;
import com.example.fastpass.exception.PasseNaoEncontradoException;
import com.example.fastpass.exception.PasseVencidoException;
import com.example.fastpass.model.TipoPasse;
import com.example.fastpass.exception.CarteirinhaNaoEncontradaException;
@Service
public class PasseService {

    private final PasseRepository passeRepository;
    private final CarteirinhaService carteirinhaService;

    public PasseService(
            PasseRepository passeRepository,
            CarteirinhaService carteirinhaService) {

        this.passeRepository = passeRepository;
        this.carteirinhaService = carteirinhaService;
    }

    public Passe consultarPasse(Long id) {
        Passe passe = passeRepository.findById(id)
                .orElseThrow(() ->
                        new PasseNaoEncontradoException(
                                "Passe não encontrado com o ID: " + id
                        ));

        return sincronizarTipoPorCarteirinha(passe);
    }

    public Passe consultarPassePorUsuario(Usuario usuario) {
        Passe passe = passeRepository.findByUsuario(usuario)
                .orElseThrow(() ->
                        new PasseNaoEncontradoException(
                                "Usuário ainda não possui passe cadastrado."
                        ));

        return sincronizarTipoPorCarteirinha(passe);
    }

    public Passe debitarSaldo(Long id, double valor) {
        Passe passe = consultarPasse(id);

        if (!passe.validar()) {
            throw new PasseVencidoException("Não foi possível debitar: o passe está inativo ou vencido.");
        }

        boolean debitoComSucesso = passe.debitar(valor);
        if (!debitoComSucesso) {
            throw new IllegalArgumentException("Saldo insuficiente ou valor inválido para débito.");
        }

        return passeRepository.save(passe);
    }

    public Passe salvar(Passe passe) {
        return passeRepository.save(passe);
    }

    public boolean validarSePodeRecarregar(Passe passe) {
        if (passe == null) {
            return false;
        }
        return passe.validar();
    }

    public Passe sincronizarTipoPorCarteirinha(Passe passe) {

        Carteirinha carteirinha = null;

        try {
            carteirinha = carteirinhaService.consultarPorUsuario(passe.getUsuario());
        } catch (CarteirinhaNaoEncontradaException e) {

        }

        if (carteirinha != null
                && carteirinhaService.validarParaTarifaEstudantil(carteirinha)) {

            passe.setTipo(TipoPasse.ESTUDANTIL);
        } else {
            passe.setTipo(TipoPasse.COMUM);
        }

        return passeRepository.save(passe);
    }
    public double calcularTarifa(Passe passe) {
        if (passe.getTipo() == TipoPasse.ESTUDANTIL) {
            return 2.25;
        }

        return 4.50;
    }

    public Passe utilizarPasse(Long id) {
        Passe passe = consultarPasse(id);

        if (!passe.validar()) {
            throw new PasseVencidoException(
                    "Não foi possível utilizar: o passe está inativo ou vencido."
            );
        }

        double tarifa = calcularTarifa(passe);

        boolean debitado = passe.debitar(tarifa);

        if (!debitado) {
            throw new IllegalArgumentException(
                    "Saldo insuficiente para utilizar o passe."
            );
        }

        return passeRepository.save(passe);
    }

}