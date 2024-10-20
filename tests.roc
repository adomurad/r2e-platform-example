app [testCases] { r2e: platform "https://github.com/adomurad/r2e-platform/releases/download/0.3.1/AcGBsqyc8iIUol_VRTRXPWNcLlDtGuje7WbMn_NdNXs.tar.br" }

# import r2e.Console
import r2e.Test exposing [test]
import r2e.Browser
import r2e.Element
import r2e.Assert

testCases = [
    test1,
]

test1 = test "inputText {enter}" \browser ->
    browser |> Browser.navigateTo! "https://devexpress.github.io/testcafe/example/"
    input = browser |> Browser.findElement! (TestId "name-input")

    input |> Element.inputText! "test{enter}"

    thankYouHeader = browser |> Browser.findElement! (TestId "thank-you-header")
    text = thankYouHeader |> Element.getText!
    text |> Assert.shouldBe "Thank you test 2"
