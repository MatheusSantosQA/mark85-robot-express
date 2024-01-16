*** Settings ***
Documentation                          Ações e Elementos do componente de nmensagens de alertas

Library                                Browser

*** Keywords ***
Alert should be
    [Arguments]                        ${expected_text}

    Wait For Elements State            css=.alert-error >> text=${expected_text}     visible                5