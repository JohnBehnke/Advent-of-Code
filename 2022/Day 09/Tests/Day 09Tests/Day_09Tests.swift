import XCTest
@testable import Day_09

final class Day_09Tests: XCTestCase {
  
  func testProblem1() throws {
    let moves = Day_09().parse(fileName: "small.test.txt")
    XCTAssertEqual(Day_09().getTailPositionCountsRopeOf(length: 2, for: moves), 13)
  }
  func testProblem2() throws {
    let moves = Day_09().parse(fileName: "large.test.txt")
    XCTAssertEqual(Day_09().getTailPositionCountsRopeOf(length: 10, for: moves), 36)
  }
}
