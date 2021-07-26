*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${mail_box} =  id=mail

*** Keywords ***
Get Email Address
    wait until keyword succeeds  10 sec  500ms  Input Box Contains Email Address
    ${email_address} =  get value  ${mail_box}
    Log  Email address received: ${email_address}
    [Return]  ${email_address}


Input Box Contains Email Address
    ${email_address} =  get value  ${mail_box}
    should contain  ${email_address}  @
