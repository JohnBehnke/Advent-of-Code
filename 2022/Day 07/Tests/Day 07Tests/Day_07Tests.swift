import XCTest
@testable import Day_07

final class Day_07Tests: XCTestCase {
  let rootDirectory = Day_07.parse(fileName: "sample.txt")
  func testProblem1() throws {
    XCTAssertEqual(Day_07.problem1(directory: rootDirectory), 95437)
  }
  func testProblem2() throws {
    XCTAssertEqual(Day_07.problem2(directory: rootDirectory, target: 30000000 - (70000000 - rootDirectory.size)), 24933642)
  }
}
