*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${addresses_label} =  xpath=//h1[contains(text(), 'Addresses')]
${checkout_on_addresses_button} =  xpath=//button[@name='processAddress']

*** Keywords ***
Wait Until Page Is Loaded
    wait until page contains element  ${addresses_label}  ${WAIT_TIME}

Click On "Proceed to checkout" Button
    click button  ${checkout_on_addresses_button}

