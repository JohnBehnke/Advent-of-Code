import XCTest
@testable import Day_12

final class Day_12Tests: XCTestCase {
  let hill = Day_12.parse(fileName: "sample.txt")
  func testProblem1() throws {
    XCTAssertEqual(Day_12.problem1(hill: hill), 31)
  }
  func testProblem2() throws {
    XCTAssertEqual(Day_12.problem2(hill: hill), 29)
  }
}
