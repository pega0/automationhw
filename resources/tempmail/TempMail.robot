*** Settings ***
Resource  po/Main.robot

*** Variables ***


*** Keywords ***
Get TempEmail Address
    ${email_address} =  Main.Get Email Address
    [Return]    ${email_address}

