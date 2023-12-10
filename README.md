# Sport Club App (api)

## RFS ( Requisitos Funcionais )

- [x] Deve ser possivel se cadastrar;
- [ ] Deve ser possivel se autenticar;
- [ ] Deve ser posssivel obter o perfil de um usuário;
- [ ] Deve ser possivel obter o número de check-ins realidos pelo usuario nas aulas.
- [ ] Deve ser possível o usuário buscar unidades próximas;
- [ ] Deve ser possivel o realizar agendamento de aulas;
- [ ] Deve ser possivel realizar o checkin da Aula.


## RNs ( Regras de negócio )

- O usuário não deve realizar mais de 2 check-in por dia.
- O usuário só pode ver aulas no range de tempo do seu plano ( vide detalhes dosplanos )

## RNFs
- [ ]  A senha do usuário precisar estar criptografada.
- [ ]  O usuário deve ser identificado com o JSON web Token.
