import XCTest
@testable import Day_02

final class Day_02Tests: XCTestCase {
    func test() throws {
      let day2 = Day_02()
      let input = day2.readFile(fileName: "test_input.txt")
      XCTAssertEqual(day2.problem1(rounds: input),15)
      XCTAssertEqual(day2.problem2(rounds: input),12)
    }
}
