*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${summary_label} =  xpath=//h1[contains(text(), 'Order summary')]
${confirm_order_button} =  xpath=//p[@id='cart_navigation']/button

*** Keywords ***
Wait Until Page Is Loaded
    wait until page contains element  ${summary_label}  ${WAIT_TIME}

Click On "I confirm my order" Button
    click button  ${confirm_order_button}



