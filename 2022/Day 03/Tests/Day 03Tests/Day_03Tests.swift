import XCTest
@testable import Day_03

final class Day_03Tests: XCTestCase {
  let input = Day_03().readFile(fileName: "test_input.txt")
  func testProblem1() throws {
    XCTAssertEqual(Day_03().problem1(rucksacks: input),157)
  }
  func testProblem2() throws {
    XCTAssertEqual(Day_03().problem2(rucksacks: input),70)
  }
}
