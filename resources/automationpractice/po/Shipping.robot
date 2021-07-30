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
    wait until element is visible  ${checkout_on_shipping_button}  ${WAIT_TIME}
    click button  ${checkout_on_shipping_button}

Agree To Terms Of Service
    wait until element is enabled  ${terms_checkbox}  ${WAIT_TIME}
    click element  ${terms_checkbox}



