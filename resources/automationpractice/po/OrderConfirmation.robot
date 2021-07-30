*** Settings ***
Library  SeleniumLibrary
Library  String

*** Variables ***
${confirmation_header_label} =  xpath=//h1[contains(text(), 'Order confirmation')]
${confirmation_label} =  xpath=//p[@class="cheque-indent"]/strong[contains(text(), 'Your order on My Store is complete.')]
${back_to_orders_link} =  xpath=//a[@title='Back to orders']
${confirmation_box} =  //div[@id="center_column"]/div[contains(concat(' ', @class, ' '), ' box ')]

*** Keywords ***
Wait Until Page Is Loaded
    wait until page contains element  ${confirmation_header_label}  ${WAIT_TIME}

Check If Order Is Confirmed
    wait until element is visible  ${confirmation_label}  ${WAIT_TIME}

Get Order Reference
    ${text} =  get text  ${confirmation_box}
    Log  ${text}
    ${regexp} =  Set Variable  your order reference ([^\s]+) in the subject
    ${order_reference} =  get regexp matches  ${text}  ${regexp}  1
    [Return]  ${order_reference[0]}

Go To Order History
    wait until element is visible  ${back_to_orders_link}  ${WAIT_TIME}
    click element  ${back_to_orders_link}

