package com.example.fastpass.repository;

import com.example.fastpass.model.Carteirinha;
import com.example.fastpass.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CarteirinhaRepository extends JpaRepository<Carteirinha, Long> {
    Optional<Carteirinha> findByUsuario(Usuario usuario);
}