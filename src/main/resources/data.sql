
INSERT INTO linha (numero, nome_rota, origem, destino) VALUES
                                                           ('101', 'Centro / Terminal Norte', 'Terminal Central', 'Terminal Norte'),
                                                           ('202', 'Universidade / Centro', 'UFAPE - Garanhuns', 'Terminal Central'),
                                                           ('303', 'Bairro Boa Vista / Centro', 'Boa Vista', 'Terminal Central');

INSERT INTO horario (horario_saida, horario_chegada, dias_semana, linha_id) VALUES
                                                                                ('05:40', '06:20', 'Seg a Sex', 1),
                                                                                ('12:00', '12:40', 'Seg a Sex', 1),
                                                                                ('18:30', '19:10', 'Seg a Sex', 1),
                                                                                ('06:00', '06:35', 'Seg a Sáb', 2),
                                                                                ('17:45', '18:20', 'Seg a Sáb', 2),
                                                                                ('07:15', '07:50', 'Seg a Sex', 3);