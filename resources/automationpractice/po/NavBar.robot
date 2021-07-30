*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${login_button} =  xpath=//a[@class='login']
${search_box} =  xpath=//input[@id='search_query_top']
${search_button} =  xpath=//button[@name='submit_search']

*** Keywords ***
Wait Until Page Is Loaded
    wait until element is visible  ${login_button}  ${WAIT_TIME}

Click "Sign in" button
    wait until element is visible  ${login_button}  ${WAIT_TIME}
    click element  ${login_button}

Enter Search Term
    [Arguments]  ${input_value}
    input text  ${search_box}  ${input_value}

Click "Search" Button
    wait until element is visible  ${search_button}  ${WAIT_TIME}
    click button  ${search_button}

