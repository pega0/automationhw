*** Settings ***
Library  SeleniumLibrary
Library  Collections

*** Variables ***
${page_header} =  xpath=//span[contains(concat(' ', @class, ' '), ' navigation_page ')]
${checkout_link} =  xpath=//p[contains(concat(' ', @class, ' '), ' cart_navigation ')]/a[@title='Proceed to checkout']
${cart_name_xpath} =  //table[@id="cart_summary"]//p[@class="product-name"]
${cart_price_xpath} =  //table[@id="cart_summary"]//span[@class="price"]/span[@class="price"]
${cart_quantity_xpath} =  //table[@id="cart_summary"]//input[contains(concat(' ', @class, ' '), ' cart_quantity_input ')]
${cart_delete_xpath} =  //table[@id="cart_summary"]//i[@class="icon-trash"]
${cart_total_amount} =  xpath=//span[@id="total_price"]
${cart_warn_box} =  xpath=//p[contains(text(), 'Your shopping cart is empty.')]

*** Keywords ***
Check If Page Is Loaded
    wait until element is visible  ${checkout_link}  ${WAIT_TIME}

Check Checkout List
    [Arguments]  ${item_count}  ${cart_names}  ${cart_prices}  ${cart_quantity}
    FOR  ${i}  IN RANGE  1  ${item_count}+1
    ${item_name} =  Get Cart Item Name  ${i}
    ${expected_name} =  get from list  ${cart_names}  ${i-1}
    should be equal  ${item_name}  ${expected_name}
    ${item_price} =  Get Cart Item Price  ${i}
    ${expected_price} =  get from list  ${cart_prices}  ${i-1}
    should be equal  ${item_price}  ${expected_price}
    ${item_quantity} =  Get Cart Item Quantity  ${i}
    ${expected_quantity} =  get from list  ${cart_quantity}  ${i-1}
    should be equal  ${item_quantity}  ${expected_quantity}
    END

Delete Item From Cart
    [Arguments]  ${delete_index}
    ${name} =  Get Cart Item Name  ${delete_index}
    wait until element is visible  xpath=(${cart_delete_xpath})[${delete_index}]  ${WAIT_TIME}
    click element  xpath=(${cart_delete_xpath})[${delete_index}]
    wait until page does not contain element  xpath=${cart_name_xpath}/a[contains(text(), '${name}')]  ${WAIT_TIME}

Wait Until Cart Is Empty
    wait until page does not contain element  ${cart_total_amount}  ${WAIT_TIME}

Get Cart Item Name
    [Arguments]  ${i}
    ${name} =  get text  xpath=(${cart_name_xpath})[${i}]
    [Return]  ${name}

Get Cart Item Price
    [Arguments]  ${i}
    ${price} =  get text  xpath=(${cart_price_xpath})[${i}]
    [Return]  ${price}

Get Cart Item Quantity
    [Arguments]  ${i}
    ${quantity} =  get value  xpath=(${cart_quantity_xpath})[${i}]
    [Return]  ${quantity}

Get Total Amount
    ${total_amount} =  get text  ${cart_total_amount}
    [Return]  ${total_amount}

Check If Cart Is Empty
    wait until element is visible  ${cart_warn_box}  ${WAIT_TIME}

Click On "Proceed to checkout" Button In Cart
    wait until element is visible  ${checkout_link}  ${WAIT_TIME}
    click element  ${checkout_link}
