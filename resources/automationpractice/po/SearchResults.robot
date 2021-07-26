*** Settings ***
Library  SeleniumLibrary
Library  String
Library  Collections


*** Variables ***
${search_label} =  xpath=//h1[contains(concat(' ', @class, ' '), ' product-listing ') and contains(concat(' ', @class, ' '), ' page-heading ')]
${search_results_xpath} =  //ul[contains(concat(' ',@class, ' '), ' product_list ')]//a[@class='product-name']

*** Keywords ***
Wait Until Page Is Loaded
    wait until element is visible  ${search_label}  ${WAIT_TIME}

Get Search Term
    ${heading_text} =  get text  ${search_label}
    [Return]  ${heading_text}

Get Search Results Label
    ${count} =  get element count  xpath=${search_results_xpath}
    ${result_labels} =  create list
    FOR  ${i}  IN RANGE  1  ${count} + 1
        ${label} =  get text  xpath=(${search_results_xpath})[${i}]
        append to list  ${result_labels}  ${label}
    END
    [Return]  ${result_labels}
