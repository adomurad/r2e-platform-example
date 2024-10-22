# r2e-platform-example

This repo is an example how to use the
[R2E platform](https://github.com/adomurad/r2e-platform) to run automatic tests
on Github Actions.

## Usage

To run the tests:

```
roc ./tests.roc
```

To run headless:

```
roc ./tests.roc --headless
```

To run in _DebugMode_ (pauses between actions, verbose loging, highlight actions
in browser):

```
roc ./tests.roc --debug
```

## Results

See example test results in:
[./exampleTestResults/basicHtmlReporter/index.html](./exampleTestResults/basicHtmlReporter/index.html)
