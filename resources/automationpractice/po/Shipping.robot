*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${shipping_label} =  xpath=//h1[contains(text(), 'Shipping')]
${checkout_on_shipping_button} =  xpath=//button[@name='processCarrier']
${terms_checkbox} =  xpath=//input[@id='cgv']

*** Keywords ***
Wait Until Page Is Loaded
    wait until page contains element  ${shipping_label}  ${WAIT_TIME}

Click On "Proceed to checkout" Button
    click button  ${checkout_on_shipping_button}

Agree To Terms Of Service
    click element  ${terms_checkbox}



