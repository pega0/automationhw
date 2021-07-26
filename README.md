# Automation Homework

## Installation

To run this test suite, the following installations are necessary.

### Python

Please download and install Python 3.9.6 from https://www.python.org/downloads/

Please make sure that after installing Python on Windows the PATH will be extended with the new 
Python binaries folder. You will need to add two folders, the installation folder and the 
Scripts folder.
(e.g. C:\Users\<current_user>\AppData\Local\Programs\Python\Python39\Scripts\ and 
C:\Users\<current_user>\AppData\Local\Programs\Python\Python39\)

If you have successfully installed python, run the following command in a console to ensure 
your installation.

`python --version`

#### PIP

If you have installed the above mentioned version of Python, you will have the 
Python package manager (PIP) also on your machine. You can check if you have PIP on
your machine with running pip --version in a console.

If you have pip installed, just run the following command.

`pip --version`

### Robot Framework

To install Robot Framework on your machine, run the following command in a console.

`pip install robotframework`

### Libraries

The file 'requirements.txt' has been configured to be able to install all the necessary
libraries. The libraries can be installed with the following command, using PIP.

`pip install -r requirements.txt`

If you prefer to install them separately please check the following section.

#### SeleniumLirary

(Only necessary if you did not install everything with the requirements.txt.)

You can install SeleniumLibrary also with PIP with the following command.

`pip install robotframework-seleniumlibrary
`
#### WebdriverManager

(Only necessary if you did not install everything with the requirements.txt.)

You can install WebdriverManager also with PIP with the following command.

`pip install webdrivermanager`

### webdrivers

Testing under Chrome and Firefox you will need to install the webdrivers for this two
browsers. Please run the following command to install them.

`webdrivermanager firefox chrome`

#### PATH

After installing the WebDrivers, you will need to add the location of the two drivers also
to the PATH. (Like the Python folders.)

##### Examples

**Chrome**

C:\Users\<current_user>\AppData\Local\rasjani\WebDriverManager\chrome\91.0.4472.101\chromedriver_win32\

**Firefox**

C:\Users\<current_user>\AppData\Local\rasjani\WebDriverManager\gecko\v0.29.0\geckodriver-v0.29.0-win64\

## Running the tests

This test suite includes five tests. They all have a separate tag, so they can be executed 
also one-by-one.

If you wish to run a selected tag, you will need to include it in the execute command
with the -i switch. (e.g. -i registration)

### Available tags

registration - Successful registration

searchproduct - Searching for products

addtocart - Add products to cart from Popular tab on Home Page

deletefromcart - Delete products from cart

order - Purchase products with bank wire

### Executing the tests

To run the tests, you will need a console. Please navigate to the root folder of this
GIT repository. Run the following command to execute the whole test set.
This command will run with the Chrome webdriver.

`robot -d results tests`

#### Using different browser

You can use the previously installed two browsers, and you can configure it in the 
run command with the -v BROWSER:firefox switch. Available options: firefox, chrome.

`robot -d results -v BROWSER:firefox tests`

#### Using a tag

This is an exapmle, how you can use the tags above. In this example the `searchproduct`
tag is used.

`robot -d results -i searchproduct -v BROWSER:firefox tests`

## Logs

You will have the logs in the **results** folder. Please open the log.html with a selected
browser, and you will see the logs of your test run.

