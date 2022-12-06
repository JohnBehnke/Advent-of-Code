import XCTest
@testable import Day_05

final class Day_05Tests: XCTestCase {
    func test() throws {
       let day5 = Day_05()
       let state = day5.readFile(fileName: "test_input.txt")
       XCTAssertEqual(day5.problem1(stacks: state.0, instructions: state.1),"CMZ")
       XCTAssertEqual(day5.problem2(stacks: state.0, instructions: state.1),"MCD")
    }
}
