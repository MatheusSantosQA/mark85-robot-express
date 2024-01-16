*** Settings ***
Documentation                          Cenários de tautenticação do usuário

Resource                               ../resources/base.resource

Library                                Collections

Test Setup                             Start Session
Test Teardown                          Take Screenshot


*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado

    ${user}                            Create Dictionary
    ...                                name=Matheus QA
    ...                                email=qa@qa.com
    ...                                password=123456
    
    Remove User from database          ${user}[email]
    Insert User from database          ${user}

    Submit login form                  ${user}
    User should be logged input        ${user}[name]

Não deve criar com senha inválida

    ${user}                            Create Dictionary
    ...                                name=New Teste
    ...                                email=new_teste@qa.com
    ...                                password=123456
    
    Remove User from database          ${user}[email]
    Insert User from database          ${user}

    Set To Dictionary                  ${user}                        password=abc123

    Submit login form                  ${user}

    Notice should be                   Ocorreu um erro ao fazer login, verifique suas credenciais.