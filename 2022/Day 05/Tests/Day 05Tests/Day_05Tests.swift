import XCTest
@testable import Day_05

final class Day_05Tests: XCTestCase {
  let state = Day_05.readFile(fileName: "sample.txt")
  func testProblem1() throws {
    XCTAssertEqual(Day_05.problem1(stacks: state.0, instructions: state.1), "CMZ")
  }
  func testProblem2() throws {
    XCTAssertEqual(Day_05.problem2(stacks: state.0, instructions: state.1), "MCD")
  }
}
