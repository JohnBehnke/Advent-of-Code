import XCTest
@testable import Day_01

final class Day_01Tests: XCTestCase {
    func test() throws {
      let day1 = Day_01()
      let input = day1.readFile(fileName: "test_input.txt")
      XCTAssertEqual(day1.problem1(input: input),24000)
      XCTAssertEqual(day1.problem2(input: input),45000)
    }
}
