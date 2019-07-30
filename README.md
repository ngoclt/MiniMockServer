`MiniMockServer` is a Swift framework which provides a very simple solution to mock API requests for UI/Integration tests on iOS.

## Inspiration

The lib is based on the code in [this article](https://jodel.com/engineering/dynamic-http-mocking/) from Michael, iOS Developer at Jodel.

## Installation

With [Cocoapods](https://cocoapods.org/):

```
  pod 'MiniMockServer', '0.1.0'
```

## Usage

- Override `initialStubs` method to setup the responses for initial requests.

```swift
  override func initialStubs() -> [HTTPStubInfo]? {
        let fakeVolumes: [[String: Any]] = []
        return [
            HTTPStubInfo(path: "/volumes?q=Harry%20Potter",
                         method: .GET,
                         response: .successObject(object: fakeVolumes))
        ]
    }
```

- Call stub function at any point to override the previous stubbing:

```swift
    func testExample() {
        let bundle = Bundle(for: type(of: self))
        guard let fileUrl = bundle.url(forResource: "search_books", withExtension: "json") else {
            XCTFail("Mock file is not exist.")
            return
        }

        stub(path: "/volumes?q=mockserver", response: .successFile(fileUrl: fileUrl))

        let textFieldSearch = app.textFields["textFieldSearch"]
        XCTAssert(waitForElementToAppear(textFieldSearch))
        textFieldSearch.clearAndEnterText("mockserver")

        textFieldSearch.typeText(XCUIKeyboardKey.return.rawValue)

        let collectionView = app.collectionViews.element(boundBy: 0)
        let firstCell = collectionView.cells.element(boundBy: 0)
        XCTAssert(waitForElementToAppear(firstCell))

        let publisherLabel = firstCell.staticTexts["publisherLabel"]
        XCTAssertEqual(publisherLabel.label, "Published by: Mock Server")
    }
```

- Stubbing response with json file:

```swift
    let bundle = Bundle(for: type(of: self))
    guard let fileUrl = bundle.url(forResource: "search_books", withExtension: "json") else {
        XCTFail("Mock file is not exist.")
        return
    }

    stub(path: "/volumes?q=mockserver", response: .successFile(fileUrl: fileUrl))
```

- Stubbing response with objects (array or dictionary):

```swift
    let fakeVolumes: [[String: Any]] = []
    stub(path: "/volumes?q=mockserver", response: .successObject(object: fakeVolumes))
```

- Stubbing error:

```swift
    stub(path: "/auth/sms-request-code",
        method: .GET,
        statusCode: 401,
        response: .error(rootCause: "Service not available",
                      errorMessage: "Unfortunately our service is not available at the moment. Please try again later."))
```

## License
MiniMockServer is released under the MIT license. See [LICENSE](https://github.com/ngoclt/MiniMockServer/blob/master/README.md) for details.
