*** Settings ***
Resource  po/Main.robot

*** Variables ***


*** Keywords ***
Get TempEmail Address
    [Documentation]  Returns a valid email address from Tempmail.
    ${email_address} =  Main.Get Email Address
    [Return]    ${email_address}

