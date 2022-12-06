import XCTest
@testable import Day_03

final class Day_03Tests: XCTestCase {
    func test() throws {
      let day3 = Day_03()
      let input = day3.readFile(fileName: "test_input.txt")
      XCTAssertEqual(day3.problem1(rucksacks: input),157)
      XCTAssertEqual(day3.problem2(rucksacks: input),70)
    }
}
