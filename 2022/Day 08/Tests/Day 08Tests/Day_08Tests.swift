import XCTest
@testable import Day_08

final class Day_08Tests: XCTestCase {
  let forest = Day_08().parse(fileName: "test_input.txt")
  func testProblem1() throws {
    XCTAssertEqual(Day_08().problem1(forest: forest), 21)
  }
  func testProblem2() throws {
    XCTAssertEqual(Day_08().problem2(forest: forest), 8)
  }
}
