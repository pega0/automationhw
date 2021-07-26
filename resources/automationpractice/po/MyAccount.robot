*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${my_account_label} =  xpath=//h1[contains(text(), 'My account')]

*** Keywords ***
Wait Until Page Is Loaded
    wait until page contains element  ${my_account_label}  ${WAIT_TIME}
