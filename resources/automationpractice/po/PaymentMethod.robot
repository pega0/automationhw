*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${payment_label} =  xpath=//h1[contains(text(), 'Please choose your payment method')]
${pay_by_bank_wire_link} =  xpath=//a[@title='Pay by bank wire']

*** Keywords ***
Wait Until Page Is Loaded
    wait until page contains element  ${payment_label}  ${WAIT_TIME}

Click On "Pay by bank wire"
    click element  ${pay_by_bank_wire_link}



