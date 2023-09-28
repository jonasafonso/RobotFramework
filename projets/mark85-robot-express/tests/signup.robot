*** Settings ***
Documentation        Cenários de teste do cadastro de usuários

Library   FakerLibrary

Resource    ../resources/base.robot

*** Test Cases ***
Deve poder cadastrar um novo usuário

    ${name}          Set Variable        Jonas Teste
    ${email}         Set Variable        jonas@teste.com
    ${Password}      Set Variable        jteste     
    
    Remove user from database        ${email}

    Start Session

    Go To        http://localhost:3000/signup

    #Checkpoint
    Wait For Elements State    css=h1       visible    5
    Get Text                   css=h1       equal      Faça seu cadastro

    Fill Text        id=name             ${name}    
    Fill Text        id=email            ${email}   
    Fill Text        id=password         ${password} 
    
    Click            id=buttonSignup
    
    Wait For Elements State        css=.notice p       visible     5
    Get Text                       css=.notice p       equal       Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${name}          Set Variable        Teste Jonas
    ${email}         Set Variable        teste@jonas.com
    ${Password}      Set Variable        jteste    

    Remove user from database    ${email}
    insert user from database    ${name}    ${email}    ${password}
   
    Start Session

    Go To        http://localhost:3000/signup

    #Checkpoint
    Wait For Elements State    css=h1       visible    5
    Get Text                   css=h1       equal      Faça seu cadastro
    
    Fill Text        id=name             ${name}    
    Fill Text        id=email            ${email}   
    Fill Text        id=password         ${Password} 
    
    Click            id=buttonSignup
    
    Wait For Elements State        css=.notice p       visible     5
    Get Text                       css=.notice p       equal       Oops! Já existe uma conta com o e-mail informado.

    