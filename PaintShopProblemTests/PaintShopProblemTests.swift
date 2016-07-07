//
//  PaintShopProblemTests.swift
//  PaintShopProblemTests
//
//  Created by Darren Leith on 06/07/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import XCTest
@testable import PaintShopProblem

class PaintShopProblemTests: XCTestCase {
	
	func testBlankInputInvalid() {
		let p = PaintShop(fileName: "testBlankInputInvalid", fileExtension: ".txt")
		let result = p.mixColors()
		let expectedResult = "Error: Test file not properly formatted"
		XCTAssertEqual(result, expectedResult, "testBlankInputInvalid failed")
	}
	
	func testIncorrectFormatInvalid() {
		let p = PaintShop(fileName: "testIncorrectFormatInvalid", fileExtension: ".txt")
		let result = p.mixColors()
		let expectedResult = "Error: Test file not properly formatted"
		XCTAssertEqual(result, expectedResult, "testIncorrectFormatInvalid failed")
	}
	
	func test1Paint2CustomersNoSolution() {
		let p = PaintShop(fileName: "test1Paint2CustomersNoSolution", fileExtension: ".txt")
		let result = p.mixColors()
		let expectedResult = "No solution exists"
		XCTAssertEqual(result, expectedResult, "test1Paint2CustomersNoSolution failed")
	}
	
	func test2Paints2CustomersValid() {
		let p = PaintShop(fileName: "test2Paints2CustomersValid", fileExtension: ".txt")
		let result = p.mixColors()
		let expectedResult = "M M"
		XCTAssertEqual(result, expectedResult, "test2Paints2CustomersValid failed")
	}
	
	func test5Paints3CustomersValid() {
		let p = PaintShop(fileName: "test5Paints3CustomersValid", fileExtension: ".txt")
		let result = p.mixColors()
		let expectedResult = "G G G G M"
		XCTAssertEqual(result, expectedResult, "test5Paints3CustomersValid failed")
	}
	
	func test5Paints14CustomersValid() {
		let p = PaintShop(fileName: "test5Paints14CustomersValid", fileExtension: ".txt")
		let result = p.mixColors()
		let expectedResult = "G M G M G"
		XCTAssertEqual(result, expectedResult, "test5Paints14CustomersValid failed")
	}
}