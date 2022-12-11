import XCTest
@testable import Day_04

final class Day_04Tests: XCTestCase {
  let input = Day_04.readFile(fileName: "sample.txt")
	func testProblem1() throws {
		XCTAssertEqual(Day_04.problem1(assignments: input),2)
	}
	func testProblem2() throws {
		XCTAssertEqual(Day_04.problem2(assignments: input),4)
	}
}
