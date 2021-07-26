*** Settings ***
Library  SeleniumLibrary
Library  String

*** Variables ***
${popular_tab} =  xpath=//a[@class='homefeatured']
${product_container_xpath} =  //ul[@id='homefeatured']//div[@class='product-container']
${add_to_cart_xpath} =  //ul[@id='homefeatured']//span[text() = 'Add to cart']
${product_name_xpath} =  //ul[@id='homefeatured']//a[contains(concat(' ', @class, ' '), 'product-name')]
${product_price_xpath} =  //ul[@id="homefeatured"]//div[@class="product-container"]/div[@class="right-block"]//span[@itemprop="price"]
${add_layer} =  xpath=//div[contains(concat(' ',@class, ' '),' layer_cart_product ')]
${continue_shopping_button} =  xpath=//span[contains(concat(' ',@class, ' '),' continue ')]
${successful_text} =  ${add_layer}//h2
${expected_successful_text} =  Product successfully added to your shopping cart
${cart} =  xpath=//div[contains(concat(' ',@class, ' '), ' shopping_cart ')]
${cart_item_count} =  xpath=//div[contains(concat(' ',@class, ' '), ' shopping_cart ')]//span[contains(concat(' ',@class, ' '), ' ajax_cart_quantity ')]
${check_out} =  xpath=//div[contains(concat(' ',@class, ' '), ' shopping_cart ')]/a
${item_quantity_number} =  xpath=//span[@id='layer_cart_product_quantity']

*** Keywords ***
Select Popular Tab
    wait until page contains element  ${popular_tab}  ${WAIT_TIME}
    click element  ${popular_tab}

Add To Cart
    [Arguments]  ${item_index}
    mouse over  xpath=(${product_container_xpath})[${item_index}]
    click element  xpath=(${add_to_cart_xpath})[${item_index}]
    wait until element is visible  ${add_layer}  ${WAIT_TIME}
    ${quantity} =  check if item added successfully to cart
    click element  ${continue_shopping_button}
    wait until element is not visible  ${add_layer}  ${WAIT_TIME}
    scroll element into view  ${cart}
    wait until element is visible  ${cart_item_count}  ${WAIT_TIME}
    [Return]  ${quantity}

Get Item Name
    [Arguments]  ${item_index}
    ${item_name} =  get text  xpath=(${product_name_xpath})[${item_index}]
    [Return]  ${item_name}

Get Item Price
    [Arguments]  ${item_index}
    ${item_price} =  get text  xpath=(${product_price_xpath})[${item_index}]
    [Return]  ${item_price}

Check If Item Added Successfully To Cart
    ${text} =  get text  ${successful_text}
    should contain  ${text}  ${expected_successful_text}
    ${quantity} =  get text  ${item_quantity_number}
    [Return]  ${quantity}

Get Item Count In Cart
    ${visible} =  run keyword and return status  element should be visible  ${cart_item_count}
    IF  ${visible}
    ${count} =  get text  ${cart_item_count}
    ELSE
    ${count} =  set variable  0
    END
    [Return]  ${count}

Go To Checkout
    click element  ${check_out}
