*** Settings ***
Documentation                          Cenários de testes do cadastros de usuários

Resource                               ../resources/base.resource

Test Setup                             Start Session
Test Teardown                          Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuário
    ### Variáveis de dados ###
    ${user}                            Create Dictionary
    ...                                name=Matheus QA
    ...                                email=teste@teste.com
    ...                                password=pwd123
    
    ### Delete de usuários ###
    Remove User from database          ${user}[email]

    ### Acessa e valida página de cadastro ###
    Go to signup Page

    ### Preenchimento do formuário ###
    Submit signup form                ${user}

    ### Valida signup com sucesso ###
    Notice should be                  Boas vindas ao Mark85, o seu gerenciador de tarefas.

Nâo deve permitir o cadastro com email duplicado
    [Tags]                             dup

    ### Variáveis de dados ###
    ${user}                            Create Dictionary
    ...                                name=QA Matheus
    ...                                email=teste1@teste.com
    ...                                password=pwd123
    
    ### Remove e gera novos dados ###
    Remove User from database          ${user}[email]
    Insert User from database          ${user}

    ### Acessa e valida página de castastro ###
    Go to signup Page

    ### Preenchimento do formuário ###
    Submit signup form                ${user}

    ### Valida signup duplicado ###
    Notice should be                  Oops! Já existe uma conta com o e-mail informado.
    
Campos obrigatórios
    [Tags]                             required

    ### Variáveis de dados ###
    ${user}                            Create Dictionary
    ...                                name=${EMPTY}
    ...                                email=${EMPTY}
    ...                                password=${EMPTY}
    
    ### Acessa e valida página de castastro ###
    Go to signup Page

    ### Preenchimento do formuário ###
    Submit signup form                ${user}

    Alert should be                   Informe seu nome completo
    Alert should be                   Informe seu e-email
    Alert should be                   Informe uma senha com pelo menos 6 digitos

Nâo deve cadastrar com email incorreto
    [Tags]                             email

    ### Variáveis de dados ###
    ${user}                            Create Dictionary
    ...                                name=Matheus QA
    ...                                email=qa.com
    ...                                password=qa@123
    
    ### Acessa e valida página de castastro ###
    Go to signup Page

    ### Preenchimento do formuário ###
    Submit signup form                ${user}

    Alert should be                   Digite um e-mail válido

Não deve cadastrar com senha muito curta
    [Tags]                            temp

    @{password_list}                  Create List                1        12        123        1234        12345

    FOR    ${password}    IN    @{password_list} 
    
        ### Variáveis de dados ###
        ${user}                            Create Dictionary
        ...                                name=Matheus QA
        ...                                email=qa@qa.com
        ...                                password=${password}
        
        ### Acessa e valida página de castastro ###
        Go to signup Page
    
        ### Preenchimento do formuário ###
        Submit signup form                ${user}
    
        Alert should be                   Informe uma senha com pelo menos 6 digitos
        
    END

Nâo deve cadastrar com senha de 1 digito
    [Tags]                             short_pass
    [Template]
    Short password                     1    

Nâo deve cadastrar com senha de 2 digito
    [Tags]                             short_pass
    [Template]
    Short password                     12    

Nâo deve cadastrar com senha de 3 digito
    [Tags]                             short_pass
    [Template]
    Short password                     123    

Nâo deve cadastrar com senha de 4 digito
    [Tags]                             short_pass
    [Template]
    Short password                     1234    

Nâo deve cadastrar com senha de 5 digito
    [Tags]                             short_pass
    [Template]
    Short password                     12345    





