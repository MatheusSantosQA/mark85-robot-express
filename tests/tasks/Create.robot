*** Settings ***
Documentation                                  Canários de cadastro de tarefas

Library                                        JSONLibrary

Resource                                       ../../resources/base.resource

Test Setup                                     Start Session
Test Teardown                                  Take Screenshot

*** Test Cases ***
Deve poder cadastar uma nova tarefas
    
    ${data}            Get fixtures            tasks                    create

    Reset user from database                   ${data}[user]
   
    Do login                                   ${data}[user]

    Go to task form
    Submit task form                           ${data}[task]
    Task should be registered                  ${data}[task][name]


    Log                ${data}
    
Não deve cadastrar tarefa com nome duplicado
    [Tags]             dup
    
    ${data}            Get fixtures            tasks                    duplicate

    ### Dado que eu tenho um novo usuário ###
    Reset user from database                   ${data}[user]
    
    ### E que o usuário já tenha cadastrado uma tarefa ###
    Create a new task from API                 ${data}

    ### E que esteja logado na aplicação web ###
    Do login                                   ${data}[user]

    ### Quando faço um cadastro de uma mesma tarefa ###
    Go to task form
    Submit task form                           ${data}[task]
    
    ### Então a aplicação retornará uma notificação de duplicidade ###
    Notice should be                           Oops! Tarefa duplicada.

Não deve cadastrar mais do três tarefas
    [Tags]             limit       

    ${data}            Get fixtures            tasks                    tags_limit
        
    Reset user from database                   ${data}[user]

    Do login                                   ${data}[user]
    
    Go to task form
    Submit task form                           ${data}[task]

    Notice should be                           Oops! Limite de tags atingido.
