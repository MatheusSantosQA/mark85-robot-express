*** Settings ***
Documentation                    Cenário de tentativa de cadastro com senha muito curta


Resource                         ../resources/base.resource
Test Template                    Short password

Test Setup                             Start Session
Test Teardown                          Take Screenshot


*** Test Cases ***
Nâo deve cadastrar com senha de 1 digito        1
Nâo deve cadastrar com senha de 2 digitos       12
Nâo deve cadastrar com senha de 3 digitos       123
Nâo deve cadastrar com senha de 4 digitos       1234
Nâo deve cadastrar com senha de 5 digitos       12345
