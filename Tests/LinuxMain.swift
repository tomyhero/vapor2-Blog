#if os(Linux)

import XCTest
@testable import AppTests

XCTMain([
    // AppTests
    testCase(BlogControllerTests.allTests),
    // testCase(PostControllerTests.allTests),
    // testCase(RouteTests.allTests)
])

#endif
