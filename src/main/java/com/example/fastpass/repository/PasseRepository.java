package com.example.fastpass.repository;

import com.example.fastpass.model.Passe;
import com.example.fastpass.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PasseRepository extends JpaRepository<Passe, Long> {
    Optional<Passe> findByUsuario(Usuario usuario);
}