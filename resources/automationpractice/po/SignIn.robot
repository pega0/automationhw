*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${registration_box} =  xpath=//input[@id='email_create']
${registration_button} =  xpath=//button[@id='SubmitCreate']

*** Keywords ***
Wait Until Page Is Loaded
    wait until element is visible  ${registration_box}  ${WAIT_TIME}

Fill Registration Email Address
    [Arguments]  ${email_address}
    input text  ${registration_box}  ${email_address}

Click On "Create an account" button
    wait until element is visible  ${registration_button}  ${WAIT_TIME}
    click button  ${registration_button}
