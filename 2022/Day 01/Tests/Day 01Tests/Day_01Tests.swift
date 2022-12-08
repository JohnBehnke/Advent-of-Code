import XCTest
@testable import Day_01

final class Day_01Tests: XCTestCase {
  let input = Day_01().readFile(fileName: "test_input.txt")
  func testProblem1() throws {
    XCTAssertEqual(Day_01().problem1(input: input),24000)
  }
  func testProblem2() throws {
    XCTAssertEqual(Day_01().problem2(input: input),45000)
  }
}
