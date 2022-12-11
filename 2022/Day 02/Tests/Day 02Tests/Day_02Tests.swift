import XCTest
@testable import Day_02

final class Day_02Tests: XCTestCase {
  let input = Day_02.readFile(fileName: "sample.txt")
  func testProblem1() throws {
    XCTAssertEqual(Day_02.problem1(rounds: input),15)
  }
  func testProblem2() throws {
    XCTAssertEqual(Day_02.problem2(rounds: input),12)
  }
}
