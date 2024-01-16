*** Settings ***

Library                                libs/database.py
Library                                Browser
Library                                JSONLibrary
                    
Resource                               env.resource

Resource                               pages/components/Alert.resource
Resource                               pages/components/Header.resource
Resource                               pages/components/Notice.resource

Resource                               pages/SignupPage.resource
Resource                               pages/LoginPage.resource
Resource                               pages/TaskCreatePage.resource
Resource                               pages/TasksPage.resource

Resource                               services.resource



*** Keywords ***
Start Session
    New Browser                        browser=${BROWSER}      headless=False         args=["--start-maximized"]
    New Context                        viewport=${None}
    New Page                           ${BASE_URL}
    Wait For Elements State            css=h1                visible                5
    Get Text                           css=h1                equal                  Faça seu login

Short password
    [Arguments]                        ${short_pass}

    ### Variáveis de dados ###
    ${user}                            Create Dictionary
    ...                                name=Matheus QA
    ...                                email=qa@qa.com
    ...                                password=${short_pass}
    
    ### Acessa e valida página de castastro ###
    Go to signup Page

    ### Preenchimento do formuário ###
    Submit signup form                 ${user}

    Alert should be                    Informe uma senha com pelo menos 6 digitos

### Helpers ###
Get fixtures
    [Arguments]                        ${file_name}                    ${scenario}

     ${data}                           Load Json From File             ${EXECDIR}/resources/fixtures/${file_name}.json            encoding=utf-8

     [Return]                          ${data}[${scenario}]

Reset user from database
    [Arguments]                        ${user}

    Clean User from database           ${user}[email]
    Insert User from database          ${user}

Create a new task from API
    [Arguments]                        ${data}

    POST user session                  ${data}[user]
    POST a new task                    ${data}[task]

Do login
    [Arguments]                        ${user}

    Submit login form                  ${user}
    User should be logged input        ${user}[name]