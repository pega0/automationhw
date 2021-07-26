*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${history_label} =  xpath=//h1[contains(text(), 'Order history')]
${reference_text} =  xpath=//table[@id="order-list"]/tbody/tr/td[1]/a
${back_to_orders_link} =  xpath=//a[@title='Back to orders']
${order_line} =  xpath=//table[@id="order-list"]/tbody/tr

*** Keywords ***
Wait Until Page Is Loaded
    wait until page contains element  ${history_label}  ${WAIT_TIME}

Check If Order Line Is Visible
    ${count} =  get element count  ${order_line}
    should be true  ${count} > 0

Get Order Reference From History
    ${text} =  get text  ${reference_text}
    [Return]  ${text}



