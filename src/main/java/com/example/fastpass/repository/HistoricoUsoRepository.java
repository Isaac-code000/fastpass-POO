package com.example.fastpass.repository;

import com.example.fastpass.model.HistoricoUso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HistoricoUsoRepository extends JpaRepository<HistoricoUso, Long> {
}