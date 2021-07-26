*** Settings ***
Resource  po/NavBar.robot
Resource  po/SignIn.robot
Resource  po/CreateAccount.robot
Resource  po/MyAccount.robot
Resource  po/SearchResults.robot
Resource  po/MainPage.robot
Resource  po/Cart.robot
Resource  po/Addresses.robot
Resource  po/Shipping.robot
Resource  po/PaymentMethod.robot
Resource  po/OrderSummary.robot
Resource  po/OrderConfirmation.robot
Resource  po/OrderHistory.robot

*** Variables ***
${first_name} =  John
${last_name} =  Doe
${password} =  John12345
${addr_first_name} =  John
${addr_last_name} =  Doe
${address} =  Black Point Rd 4001
${city} =  Honolulu
${state} =  Hawaii
${zip} =  96816
${country} =  United States
${mobile_phone} =  +18009151469
${alias} =  Home


*** Keywords ***
Click on "Sign in" button
    NavBar.Wait Until Page Is Loaded
    NavBar.Click "Sign in" button

Register Email Address
    [Arguments]  ${email_address}
    SignIn.Wait Until Page Is Loaded
    SignIn.Fill Registration Email Address   ${email_address}
    SignIn.Click On "Create an account" button

Fill In Registration Form
    CreateAccount.Wait Until Page Is Loaded
    CreateAccount.Fill "First name" Field  ${first_name}
    CreateAccount.Fill "Last name" Field  ${last_name}
    CreateAccount.Fill "Password" Field  ${password}
    CreateAccount.Fill "Address first name" Field  ${addr_first_name}
    CreateAccount.Fill "Address last name" Field  ${addr_last_name}
    CreateAccount.Fill "Address" Field  ${address}
    CreateAccount.Fill "City" Field  ${city}
    CreateAccount.Fill "State" Field  ${state}
    CreateAccount.Fill "Zip" Field  ${zip}
    CreateAccount.Fill "Country" Field  ${country}
    CreateAccount.Fill "Mobile phone" Field  ${mobile_phone}
    CreateAccount.Fill "Alias" Field  ${alias}
    CreateAccount.Click On "Register" button

Check If "My account" Page Is Loaded
    MyAccount.Wait Until Page Is Loaded

Search For Products
    [Arguments]  ${input_value}
    NavBar.Wait Until Page Is Loaded
    NavBar.Enter Search Term  ${input_value}
    NavBar.Click "Search" Button

Check Search Results Are Loaded
    [Arguments]  ${search_text}
    SearchResults.Wait Until Page Is Loaded
    ${search_label} =  SearchResults.Get Search Term
    ${expected_value} =  string.convert to upper case  Search${SPACE}${SPACE}"${search_text}"
    ${upcase_search_text} =  string.convert to upper case  ${search_text}
    should start with  ${search_label}  ${expected_value}

    ${result_labels} =  SearchResults.Get Search Results Label
    FOR  ${item}  IN  @{result_labels}
        ${upcase_item} =  string.convert to upper case  ${item}
        should contain  ${upcase_item}  ${upcase_search_text}
    END

Select Popular Tab
    MainPage.Select Popular Tab

Add To Cart From Popular Tab
    [Arguments]  ${item_count}
    @{cart_names} =  create list
    @{cart_prices} =  create list
    @{cart_quantity} =  create list
    FOR  ${i}  IN RANGE  1  ${item_count}+1
    ${count_before} =  MainPage.Get Item Count In Cart
    ${item_name} =  MainPage.Get Item Name  ${i}
    IF  ${i} == 1
    ${name_index} =  set variable  -1
    ELSE
    ${name_index} =  get index from list  ${cart_names}  ${item_name}
    END
    ${item_quantity} =  MainPage.Add To Cart  ${i}
    IF  ${name_index} == -1
    append to list  ${cart_names}  ${item_name}
    ${item_price} =  MainPage.Get Item Price  ${i}
    append to list  ${cart_prices}  ${item_price}
    append to list  ${cart_quantity}  1
    ELSE
    set list value  ${cart_quantity}  ${name_index}  ${item_quantity}
    END
    ${count_after} =  MainPage.Get Item Count In Cart
    ${count_after} =  convert to integer  ${count_after}
    ${expected_number} =  evaluate  ${count_before}+1
    should be equal  ${expected_number}  ${count_after}
    END
    [Return]  ${cart_names}  ${cart_prices}  ${cart_quantity}

Go To Checkout Page
    MainPage.Go To Checkout
    Cart.Check If Page Is Loaded

Check Items In Cart
    [Arguments]  ${item_count}  ${cart_names}  ${cart_prices}  ${cart_quantity}
    Cart.Check Checkout List  ${item_count}  ${cart_names}  ${cart_prices}  ${cart_quantity}

Delete Items From Cart
    [Arguments]  ${item_count}
    FOR  ${i}  IN RANGE  1  ${item_count}
    ${total_amount} =  Cart.Get Total Amount
    ${total} =  replace string  ${total_amount}  $  ${EMPTY}
    ${total} =  convert to number  ${total}
    ${item_price} =  Cart.Get Cart Item Price  1
    ${price} =  Get Number  ${item_price}
    ${expected_total} =  evaluate  ${total} - ${price}
    ${expected_total} =  convert to number  ${expected_total}  2
    Cart.Delete Item From Cart  1
    ${remaring_total} =  Cart.Get Total Amount
    ${remaring} =  Get Number  ${remaring_total}
    should be equal  ${expected_total}  ${remaring}
    END
    Cart.Delete Item From Cart  1
    Cart.Wait Until Cart Is Empty

Get Number
    [Arguments]  ${input}
    ${converted} =  replace string  ${input}  $  ${EMPTY}
    ${converted} =  convert to number  ${converted}  2
    [Return]  ${converted}

Check If Cart Is Empty
    Cart.Check If Cart Is Empty

Proceed To Checkout In Cart
    Cart.Check If Page Is Loaded
    Cart.Click On "Proceed to checkout" Button In Cart

Proceed To Checkout At Addresses
    Addresses.Wait Until Page Is Loaded
    Addresses.Click On "Proceed to checkout" Button

Proceed To Checkout At Shipping
    Shipping.Wait Until Page Is Loaded
    Shipping.Agree To Terms Of Service
    Shipping.Click On "Proceed to checkout" Button

Proceed To Order At Payment
    PaymentMethod.Wait Until Page Is Loaded
    PaymentMethod.Click On "Pay by bank wire"

Confirm Order On The Summary Page
    OrderSummary.Wait Until Page Is Loaded
    OrderSummary.Click On "I confirm my order" Button

Check Order Confirmation Page
    OrderConfirmation.Wait Until Page Is Loaded
    OrderConfirmation.Check If Order Is Confirmed
    ${order_reference} =  OrderConfirmation.Get Order Reference
    [Return]  ${order_reference}

Proceed To History From Confirmation
    OrderConfirmation.Go To Order History
    OrderHistory.Wait Until Page Is Loaded

Check If Order Exists On History
    OrderHistory.Check If Order Line Is Visible

Get Order Reference From History Page
    ${reference} =  OrderHistory.Get Order Reference From History
    [Return]  ${reference}


