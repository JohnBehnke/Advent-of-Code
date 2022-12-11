import XCTest
@testable import Day_11

final class Day_11Tests: XCTestCase {
  let monkies = Day_11.parse(fileName: "sample.txt")
    func testProblem1() throws {
      XCTAssertEqual(Day_11.problem1(monkies: monkies), 10605)
    }
  func testProblem2() throws {
    XCTAssertEqual(Day_11.problem2(monkies: monkies), 2713310158)
  }
}
