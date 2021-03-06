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
    [Documentation]  This test case checks if the registration is possible on the page.
    Register With New Email Address
    Page "My Account" Is Visible


Search For Products
    [Tags]  searchproduct
    [Documentation]  This test case checks if it is possible to search for products on the home page.
    Enter Search Term And Press Search
    Check If Search Results Are Visible

Add products to cart from Popular tab on Home Page
    [Tags]  addtocart
    [Documentation]  This test case checks if it is possible to add products to cart on the home page from the popular tab.
    AutomationPractice.Select Popular Tab
    ${cart_names}  ${cart_prices}  ${cart_quantity} =  AutomationPractice.Add To Cart From Popular Tab  ${PRODUCT_COUNT}
    AutomationPractice.Go To Checkout Page
    AutomationPractice.Check Items In Cart  ${PRODUCT_COUNT}  ${cart_names}  ${cart_prices}  ${cart_quantity}


Delete From Cart
    [Tags]  deletefromcart
    [Documentation]  This test case checks if it is possible to delete items from the cart.
    AutomationPractice.Select Popular Tab
    ${cart_names}  ${cart_prices}  ${cart_quantity} =  AutomationPractice.Add To Cart From Popular Tab  ${PRODUCT_COUNT}
    AutomationPractice.Go To Checkout Page
    AutomationPractice.Delete Items From Cart  ${PRODUCT_COUNT}
    AutomationPractice.Check If Cart Is Empty


Order Products On Page
    [Tags]  order
    [Documentation]  This test case checks if it is possible to purchase products with bank wire.
    AutomationPractice.Add To Cart From Popular Tab  ${PRODUCT_COUNT}
    AutomationPractice.Go To Checkout Page
    AutomationPractice.Proceed To Checkout In Cart
    Register With New Email Address
    Go Through Order Summary



*** Keywords ***
Get New Email Address
    [Documentation]  The function requests for a valid email address from Tempmail, and returns this email address.
    Common.Open New Browser  ${TEMPMAIL_URL}  ${BROWSER}  ${TEMPMAIL_WINDOW}
    ${temp_email} =  TempMail.Get TempEmail Address
    Common.Close Selected Window
    [Return]  ${temp_email}

Switch To Main Browser
    [Documentation]  Switch the focus to the main browser window.
    switch browser  ${MAIN_WINDOW}

Click On "Sign In" Button
    [Documentation]  Click on the "Sign in" button.
    AutomationPractice.Click on "Sign in" button

Register Email Address
    [Documentation]  Go through the registration process for the received email address.
    [Arguments]  ${email_address}
    AutomationPractice.Register Email Address  ${email_address}

Fill In "Create Account" Form
    [Documentation]  Fill in every required fields on the registration form.
    AutomationPractice.Fill In Registration Form

Page "My Account" Is Visible
    [Documentation]  Waits until the "My Account" page is loaded.
    MyAccount.Wait Until Page Is Loaded

Enter Search Term And Press Search
    [Documentation]  Search for products with the given search term.
    AutomationPractice.Search For Products  ${SEARCH_TERM}

Check If Search Results Are Visible
    [Documentation]  Checks if the search result page is loaded.
    AutomationPractice.Check Search Results Are Loaded  ${SEARCH_TERM}

Register With New Email Address
    [Documentation]  The function requests for an email address and goes through the registration process with it.
    ${temp_email} =  Get New Email Address
    Switch To Main Browser
    Click "Sign in" button
    Register Email Address  ${temp_email}
    Fill In "Create Account" Form

Go Through Order Summary
    [Documentation]  The function goes through the ordering process.
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

