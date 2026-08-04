package com.example.fastpass.repository;

import com.example.fastpass.model.Linha;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LinhaRepository extends JpaRepository<Linha, Long> {
}