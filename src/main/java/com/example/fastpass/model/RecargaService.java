package com.example.fastpass.model;

import com.example.fastpass.exception.RecargaNaoEncontradaException;
import com.example.fastpass.model.Recarga;
import com.example.fastpass.repository.RecargaRepository;
import org.springframework.stereotype.Service;

@Service
public class RecargaService {

    private final RecargaRepository recargaRepository;

    public RecargaService(RecargaRepository recargaRepository) {
        this.recargaRepository = recargaRepository;
    }

    public Recarga buscarPorId(Long id) {
        return recargaRepository.findById(id)
                .orElseThrow(() -> new RecargaNaoEncontradaException("Recarga não encontrada: id " + id));
    }

    public Recarga salvar(Recarga recarga) {
        return recargaRepository.save(recarga);
    }

    /**
     * Confirma a recarga (delegando a regra de negócio para a entidade,
     * que decide o status com base no resultado do pagamento) e persiste.
     */
    public Recarga confirmar(Long id) {
        Recarga recarga = buscarPorId(id);
        recarga.confirmar();
        return recargaRepository.save(recarga);
    }
}
