import XCTest
@testable import Day_10

final class Day_10Tests: XCTestCase {
  let program = Day_10.parse(fileName: "sample.txt")
  func problem1() throws {
    XCTAssertEqual(Day_10.problem1(program: program), 13140)
  }
}
