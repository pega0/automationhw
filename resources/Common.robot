*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***
Initialize Test
    [Documentation]  Opens a new browser and maximizes the window.
    Open New Browser  ${URL}  ${BROWSER}  ${MAIN_WINDOW}
    Maximize Browser

Open New Browser
    [Documentation]  Opens a browser.
    [Arguments]  ${url}  ${browser}  ${alias}
    open browser  ${url}  ${browser}  ${alias}

Close Selected Window
    [Documentation]  Closes the browser window.
    close window

Maximize Browser
    [Documentation]  Maximizes the browser window.
    maximize browser window

Teardown Test
    [Documentation]  Closes all browsers.
    close all browsers
