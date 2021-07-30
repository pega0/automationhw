*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${first_name_field} =  xpath=//input[@id='customer_firstname']
${last_name_field} =  xpath=//input[@id='customer_lastname']
${password_field} =  xpath=//input[@id='passwd']
${addr_first_name_field} =  xpath=//input[@id='firstname']
${addr_last_name_field} =  xpath=//input[@id='lastname']
${address_field} =  xpath=//input[@id='address1']
${city_field} =  xpath=//input[@id='city']
${state_field} =  xpath=//select[@id='id_state']
${zip_field} =  xpath=//input[@id='postcode']
${country_field} =  xpath=//select[@id='id_country']
${mobile_phone_field} =  xpath=//input[@id='phone_mobile']
${alias_field} =  xpath=//input[@id='alias']
${register_button} =  xpath=//button[@id='submitAccount']


*** Keywords ***
Wait Until Page Is Loaded
    wait until element is visible  ${first_name_field}  ${WAIT_TIME}

Fill "First name" Field
    [Arguments]  ${value}
    input text  ${first_name_field}  ${value}

Fill "Last name" Field
    [Arguments]  ${value}
    input text  ${last_name_field}  ${value}

Fill "Password" Field
    [Arguments]  ${value}
    input text  ${password_field}  ${value}

Fill "Address first name" Field
    [Arguments]  ${value}
    input text  ${addr_first_name_field}  ${value}

Fill "Address last name" Field
    [Arguments]  ${value}
    input text  ${addr_last_name_field}  ${value}

Fill "Address" Field
    [Arguments]  ${value}
    input text  ${address_field}  ${value}

Fill "City" Field
    [Arguments]  ${value}
    input text  ${city_field}  ${value}

Fill "State" Field
    [Arguments]  ${value}
    select from list by label  ${state_field}   ${value}

Fill "Zip" Field
    [Arguments]  ${value}
    input text  ${zip_field}  ${value}

Fill "Country" Field
    [Arguments]  ${value}
    select from list by label  ${country_field}  ${value}

Fill "Mobile phone" Field
    [Arguments]  ${value}
    input text  ${mobile_phone_field}  ${value}

Fill "Alias" Field
    [Arguments]  ${value}
    input text  ${alias_field}  ${value}

Click On "Register" button
    wait until element is visible  ${register_button}  ${WAIT_TIME}
    click button  ${register_button}

