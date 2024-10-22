app [testCases] { r2e: platform "https://github.com/adomurad/r2e-platform/releases/download/0.5.0/b0mNSQVGQeCxZY-pXFxasKCNf8aB2899UBwnwbqNV9Y.tar.br" }

import r2e.Test exposing [test]
import r2e.Debug
import r2e.Browser
import r2e.Element
import r2e.Assert

testCases = [
    test1,
    test2,
]

test1 = test "find roc in google" \browser ->
    # open google
    browser |> Browser.navigateTo! "http://google.com"
    # find cookie confirm button
    button = browser |> Browser.findElement! (Css "#L2AGLb")
    # confirm cookies
    button |> Element.click!
    # find search input
    searchInput = browser |> Browser.findElement! (Css ".gLFyf")
    # search for "roc lang"
    searchInput |> Element.inputText! "roc lang{enter}"
    # wait for demo purpose
    Debug.wait! 500
    # find all search results
    searchResults = browser |> Browser.findElements! (Css ".yuRUbf h3")
    # get first result
    firstSearchResult = searchResults |> List.first |> Task.fromResult!
    # click on first result
    firstSearchResult |> Element.click!
    # wait for demo purpose
    Debug.wait! 1000
    # find header text
    header = browser |> Browser.findElement! (Css "#homepage-h1")
    # get header text
    headerText = header |> Element.getText!
    # check text
    headerText |> Assert.shouldBe! "Roc"

test2 = test "use roc repl" \browser ->
    # go to roc-lang.org
    browser |> Browser.navigateTo! "http://roc-lang.org"
    # find repl input
    replInput = browser |> Browser.findElement! (Css "#source-input")
    # wait for the repl to initialize
    Debug.wait! 100
    # send keys to repl
    replInput |> Element.inputText! "0.1+0.2{enter}"
    # wait for demo purpose
    Debug.wait! 2000
    # find repl output element
    outputEl = browser |> Browser.findElement! (Css ".output")
    # get output text
    outputText = outputEl |> Element.getText!
    # assert text - fail for demo purpose
    outputText |> Assert.shouldBe "0.3000000001 : Frac *"
