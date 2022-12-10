import XCTest
@testable import Day_06

final class Day_06Tests: XCTestCase {
  let input = Day_06().readFile(fileName: "sample.txt")
  func testProblem1() throws {
    XCTAssertEqual(Day_06().problem1(input: input),7)
  }
  func testProblem2() throws {
    XCTAssertEqual(Day_06().problem2(input: input),19)
  }
}
