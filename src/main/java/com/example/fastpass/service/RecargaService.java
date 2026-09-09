package com.example.fastpass.service;

import com.example.fastpass.exception.RecargaNaoEncontradaException;
import com.example.fastpass.model.Passe;
import com.example.fastpass.model.Recarga;
import com.example.fastpass.repository.RecargaRepository;
import org.springframework.stereotype.Service;

@Service
public class RecargaService {

    private final RecargaRepository recargaRepository;
    private final PasseService passeService;

    public RecargaService(RecargaRepository recargaRepository,
                          PasseService passeService) {
        this.recargaRepository = recargaRepository;
        this.passeService = passeService;
    }

    public Recarga buscarPorId(Long id) {
        return recargaRepository.findById(id)
                .orElseThrow(() ->
                        new RecargaNaoEncontradaException(
                                "Recarga não encontrada: id " + id
                        ));
    }

    public Recarga salvar(Recarga recarga) {
        return recargaRepository.save(recarga);
    }

    public Recarga confirmar(Long id) {
        Recarga recarga = buscarPorId(id);

        boolean confirmada = recarga.confirmar();

        if (confirmada) {
            Passe passe = recarga.getPasse();
            passe.recarregar(recarga.getValor());
            passeService.salvar(passe);
        }

        return recargaRepository.save(recarga);
    }
}