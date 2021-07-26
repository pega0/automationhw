*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***
Initialize Test
    Open New Browser  ${URL}  ${BROWSER}  ${MAIN_WINDOW}
    Maximize Browser

Open New Browser
    [Arguments]  ${url}  ${browser}  ${alias}
    open browser  ${url}  ${browser}  ${alias}

Close Selected Window
    close window

Maximize Browser
    maximize browser window

Teardown Test
    close all browsers
