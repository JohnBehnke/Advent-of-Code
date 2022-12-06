import XCTest
@testable import Day_04

final class Day_04Tests: XCTestCase {
    func test() throws {
      let day4 = Day_04()
      let input = day4.readFile(fileName: "test_input.txt")
      XCTAssertEqual(day4.problem1(assignments: input),2)
      XCTAssertEqual(day4.problem2(assignments: input),4)
    }
}
