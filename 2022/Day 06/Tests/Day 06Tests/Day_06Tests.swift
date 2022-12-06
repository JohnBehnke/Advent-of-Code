import XCTest
@testable import Day_06

final class Day_06Tests: XCTestCase {
    func test() throws {
        let day6 = Day_06()
        let input = day6.readFile(fileName: "test_input.txt")
        XCTAssertEqual(day6.problem1(input: input),7)
        XCTAssertEqual(day6.problem2(input: input),19)
    }
}
