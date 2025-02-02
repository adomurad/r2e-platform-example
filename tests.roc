app [test_cases, config] { r2e: platform "https://github.com/adomurad/r2e-platform/releases/download/0.9.0/18rG0wcljf8EmqFsLkFc8bioPpNZPyH_NJ83oCdmPrQ.tar.br" }

import r2e.Test exposing [test]
import r2e.Config
import r2e.Debug
import r2e.Browser
import r2e.Element
import r2e.Assert

config = Config.default_config

test_cases = [
    test1,
    test2,
    test3,
]

test1 = test(
    "fill out a fake form",
    |browser|
        # open the test page
        browser |> Browser.navigate_to!("https://adomurad.github.io/e2e-test-page/")?
        # find the framework name input by data-testid
        framework_input = browser |> Browser.find_element!(TestId("framework-name"))?
        # send text to input
        framework_input |> Element.input_text!("R2E Platform")?
        # find the test count input by id
        test_count_input = browser |> Browser.find_element!(Css("#testCount"))?
        # send text to input
        test_count_input |> Element.input_text!("55")?
        # find the checkbox
        is_production_checkbox = browser |> Browser.find_element!(TestId("isProduction"))?
        # click the checkbox
        is_production_checkbox |> Element.click!()?
        # find the submit button
        submit_button = browser |> Browser.find_element!(Css("#submit-button"))?
        # click the submit button
        submit_button |> Element.click!()?
        # the page title should have changed
        browser |> Assert.title_should_be!("E2E Testing - Summary Page")?
        # find the summary page header
        summary_header = browser |> Browser.find_element!(TestId("summary-header"))?
        # the header should be "Thank You!"
        summary_header |> Assert.element_should_have_text!("Thank You!"),
)

test2 = test(
    "test form validation",
    |browser|
        # open the test page
        browser |> Browser.navigate_to!("https://adomurad.github.io/e2e-test-page/")?
        # find the test count input by id
        test_count_input = browser |> Browser.find_element!(Css("#testCount"))?
        # send text to input
        test_count_input |> Element.input_text!("2")?
        # find the submit button
        submit_button = browser |> Browser.find_element!(Css("#submit-button"))?
        # click the submit button
        submit_button |> Element.click!()?
        # wait for the error message to become visible
        Debug.wait!(200) # TODO - asserts in R2E will handle in platform
        # find the error message
        test_count_error = browser |> Browser.find_element!(TestId("testCountError"))?
        # check the error message text
        test_count_error |> Assert.element_should_have_text!("At least 5 tests are required"),
)

test3 = test(
    "use roc repl",
    |browser|
        # go to roc-lang.org
        browser |> Browser.navigate_to!("http://roc-lang.org")?
        # find repl input
        repl_input = browser |> Browser.find_element!(Css("#source-input"))?
        # wait for the repl to initialize
        Debug.wait!(200)
        # send keys to repl
        repl_input |> Element.input_text!("0.1+0.2{enter}")?
        # find repl output element
        output_el = browser |> Browser.find_element!(Css(".output"))?
        # get output text
        output_text = output_el |> Element.get_text!()?
        # assert text - fail for demo purpose
        output_text |> Assert.should_be("0.3000000001 : Frac *"),
)
