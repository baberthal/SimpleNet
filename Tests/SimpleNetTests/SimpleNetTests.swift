import XCTest
@testable import SimpleNet

class SimpleNetTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SimpleNet().text, "Hello, World!")
    }


    static var allTests : [(String, (SimpleNetTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
