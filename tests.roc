app [testCases, config] { r2e: platform "https://github.com/adomurad/r2e-platform/releases/download/0.6.0/7vFDzZ7T9Thdkgwhl3jRVJyQBNUPm1tDIqeEc5RhRnI.tar.br" }

import r2e.Test exposing [test]
import r2e.Config
import r2e.Debug
import r2e.Browser
import r2e.Element
import r2e.Assert

config = Config.defaultConfig

testCases = [
    test1,
    test2,
    test3,
]

test1 = test "fill out a fake form" \browser ->
    # open the test page
    browser |> Browser.navigateTo! "https://adomurad.github.io/e2e-test-page/"
    # find the framework name input by data-testid
    frameworkInput = browser |> Browser.findElement! (TestId "framework-name")
    # send text to input
    frameworkInput |> Element.inputText! "R2E Platform"
    # find the test count input by id
    testCountInput = browser |> Browser.findElement! (Css "#testCount")
    # send text to input
    testCountInput |> Element.inputText! "55"
    # find the checkbox
    isProductionCheckbox = browser |> Browser.findElement! (TestId "isProduction")
    # click the checkbox
    isProductionCheckbox |> Element.click!
    # find the submit button
    submitButton = browser |> Browser.findElement! (Css "#submit-button")
    # click the submit button
    submitButton |> Element.click!
    # the page title should have changed
    browser |> Assert.titleShouldBe! "E2E Testing - Summary Page"
    # find the summary page header
    summaryHeader = browser |> Browser.findElement! (TestId "summary-header")
    # the header should be "Thank You!"
    summaryHeader |> Assert.elementShouldHaveText! "Thank You!"

test2 = test "test form validation" \browser ->
    # open the test page
    browser |> Browser.navigateTo! "https://adomurad.github.io/e2e-test-page/"
    # find the test count input by id
    testCountInput = browser |> Browser.findElement! (Css "#testCount")
    # send text to input
    testCountInput |> Element.inputText! "2"
    # find the submit button
    submitButton = browser |> Browser.findElement! (Css "#submit-button")
    # click the submit button
    submitButton |> Element.click!
    # wait for the error message to become visible
    Debug.wait! 200 # TODO - asserts in R2E will handle in platform
    # find the error message
    testCountError = browser |> Browser.findElement! (TestId "testCountError")
    # check the error message text
    testCountError |> Assert.elementShouldHaveText! "At least 5 tests are required"

test3 = test "use roc repl" \browser ->
    # go to roc-lang.org
    browser |> Browser.navigateTo! "http://roc-lang.org"
    # find repl input
    replInput = browser |> Browser.findElement! (Css "#source-input")
    # wait for the repl to initialize
    Debug.wait! 300
    # send keys to repl
    replInput |> Element.inputText! "0.1+0.2{enter}"
    # find repl output element
    outputEl = browser |> Browser.findElement! (Css ".output")
    # get output text
    outputText = outputEl |> Element.getText!
    # assert text - fail for demo purpose
    outputText |> Assert.shouldBe "0.3 : Frac *"
