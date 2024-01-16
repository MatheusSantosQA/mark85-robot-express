*** Settings ***
Documentation                          Cenários de testes de exclusão de tarefas


Resource                               ../../resources/base.resource

Test Setup                             Start Session
Test Teardown                          Take Screenshot

*** Test Cases ***
Deve poder apagar uma terefa indesejada
    ${data}        Get fixtures        tasks            delete

    Reset user from database           ${data}[user]
    
    Create a new task from API         ${data}

    Do login                           ${data}[user]

    Remove task                        ${data}[task][name]
    Task should be not exist           ${data}[task][name]