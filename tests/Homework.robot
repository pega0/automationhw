*** Settings ***
Documentation  Testing if registration is possile
Resource    ../resources/Common.robot
Resource    ../resources/automationpractice/AutomationPractice.robot
Resource    ../resources/tempmail/TempMail.robot

Test Setup  Common.Initialize Test
Test Teardown  Common.Teardown Test

*** Variables ***
${URL} =  http://automationpractice.com
${TEMPMAIL_URL} =  https://temp-mail.org/en/
${BROWSER} =  chrome
${MAIN_WINDOW} =  mainwindow
${TEMPMAIL_WINDOW} =  tempmail
${WAIT_TIME} =  15
${SEARCH_TERM} =  Printed
${PRODUCT_COUNT} =  3

*** Test Cases ***
Register With New Email Address
    [Tags]  registration
    Register With New Email Address
    Page "My Account" Is Visible


Search For Products
    [Tags]  searchproduct
    Enter Search Term And Press Search
    Check If Search Results Are Visible

Add products to cart from Popular tab on Home Page
    [Tags]  addtocart
    AutomationPractice.Select Popular Tab
    ${cart_names}  ${cart_prices}  ${cart_quantity} =  AutomationPractice.Add To Cart From Popular Tab  ${PRODUCT_COUNT}
    AutomationPractice.Go To Checkout Page
    AutomationPractice.Check Items In Cart  ${PRODUCT_COUNT}  ${cart_names}  ${cart_prices}  ${cart_quantity}


Delete From Cart
    [Tags]  deletefromcart
    AutomationPractice.Select Popular Tab
    ${cart_names}  ${cart_prices}  ${cart_quantity} =  AutomationPractice.Add To Cart From Popular Tab  ${PRODUCT_COUNT}
    AutomationPractice.Go To Checkout Page
    AutomationPractice.Delete Items From Cart  ${PRODUCT_COUNT}
    AutomationPractice.Check If Cart Is Empty


Order Products On Page
    [Tags]  order
    AutomationPractice.Add To Cart From Popular Tab  ${PRODUCT_COUNT}
    AutomationPractice.Go To Checkout Page
    AutomationPractice.Proceed To Checkout In Cart
    Register With New Email Address
    Go Through Order Summary



*** Keywords ***
Get New Email Address
    Common.Open New Browser  ${TEMPMAIL_URL}  ${BROWSER}  ${TEMPMAIL_WINDOW}
    ${temp_email} =  TempMail.Get TempEmail Address
    Common.Close Selected Window
    [Return]  ${temp_email}

Switch To Main Browser
    switch browser  ${MAIN_WINDOW}

Click On "Sign In" Button
    AutomationPractice.Click on "Sign in" button

Register Email Address
    [Arguments]  ${email_address}
    AutomationPractice.Register Email Address  ${email_address}

Fill In "Create Account" Form
    AutomationPractice.Fill In Registration Form

Page "My Account" Is Visible
    MyAccount.Wait Until Page Is Loaded

Enter Search Term And Press Search
    AutomationPractice.Search For Products  ${SEARCH_TERM}

Check If Search Results Are Visible
    AutomationPractice.Check Search Results Are Loaded  ${SEARCH_TERM}

Register With New Email Address
    ${temp_email} =  Get New Email Address
    Switch To Main Browser
    Click "Sign in" button
    Register Email Address  ${temp_email}
    Fill In "Create Account" Form

Go Through Order Summary
    AutomationPractice.Proceed To Checkout In Cart
    AutomationPractice.Proceed To Checkout At Addresses
    AutomationPractice.Proceed To Checkout At Shipping
    AutomationPractice.Proceed To Order At Payment
    AutomationPractice.Confirm Order On The Summary Page
    ${expected_reference} =  AutomationPractice.Check Order Confirmation Page
    AutomationPractice.Proceed To History From Confirmation
    AutomationPractice.Check If Order Exists On History
    ${received_reference} =  AutomationPractice.Get Order Reference From History Page
    should be equal  ${expected_reference}  ${received_reference}

