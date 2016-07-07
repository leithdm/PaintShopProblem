//
//  PaintShop.swift
//  PaintShopProblem
//
//  Created by Darren Leith on 06/07/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import Foundation

final class PaintShop {
	
	static let NO_SOLUTION = "No solution exists"
	static let ERROR = "Error: Test file not properly formatted"
	static let GLOSS = "G"
	
	//MARK: properties
	
	var noOfColors = 0
	var customers = [Customer]()
	var finalizedFinishes = [Int : Finish]()
	
	//MARK: initializer that accepts file input
	
	init(fileName: String, fileExtension: String) {
		readFile(fileName, fileExtension: fileExtension)
	}
	
	//MARK: mix the colors.
	
	func mixColors() -> String {
		
		guard customers.count != 0 || noOfColors != 0 else {
			return PaintShop.ERROR
		}
		
		customers = customers.sort()
		
		for customer in customers {
			if (customer.paintPreferences.count == 1) {
				var paintContainer = [Paint]()
				let fixedPaint = calculatePaintForCustomer(customer, paintCandidates: &paintContainer)
				if (fixedPaint == nil) {
					return PaintShop.NO_SOLUTION
				}

				if let fixedPaint = fixedPaint {
					finalizedFinishes[fixedPaint.color] = fixedPaint.finish
				}
			} else {
				var paintCandidates = [Paint]()
				let fixedPaint = calculatePaintForCustomer(customer, paintCandidates: &paintCandidates)
				
				if (fixedPaint != nil) {
					continue
				}
				else if (paintCandidates.isEmpty) {
					return PaintShop.NO_SOLUTION
				}
				
				var paintToSelect = paintCandidates.first
				for paint in paintCandidates {
					if (paint.finish == Finish.Gloss) {
						paintToSelect = paint
					}
				}
				finalizedFinishes[(paintToSelect!.color)] = paintToSelect!.finish
			}
		}
		return createOutput(finalizedFinishes, numOfColors: noOfColors)
	}
	
	
	//MARK: read customers and colors from file
	
	func readFile(fileName: String, fileExtension: String) {
		if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtension) {
			if let fileContents = try? String(contentsOfFile: path, usedEncoding: nil) {
				let lines = fileContents.componentsSeparatedByString("\n")
				if let fileNumOfColors = Int(lines[0]) {
					self.noOfColors = fileNumOfColors
					for i in 1..<lines.count {
						let newCustomer = Customer()
						let line = lines[i].componentsSeparatedByString(" ")
						for i in 0..<line.count {
							if let color = Int(line[i]) {
								let stringFinish = line[i+1]
								if let finish = Finish.parseFinish(stringFinish) {
									newCustomer.addPaintPreference(color, finish: finish)
								}
							}
						}
						customers.append(newCustomer)
					}
				}
			}
		}
	}
	
	
	//MARK: calculate paint for the customer
	
	func calculatePaintForCustomer(customer: Customer, inout paintCandidates: [Paint]) -> Paint? {
		for paint in customer.paintPreferences {
			let color = paint.color
			let finish = paint.finish
			let fixedFinish = finalizedFinishes[color]
			
			if (customer.paintPreferences.count == 1) {
				if (fixedFinish == nil || fixedFinish == finish) {
					return paint
				} else {
					return nil
				}
			} else {
				if (fixedFinish == nil) {
					paintCandidates.append(paint)
				} else if (fixedFinish == finish)  {
					return paint
				}
			}
		}
		return nil
	}
	
	//MARK: create output
	
	func createOutput(fixedFinishes: [Int: Finish], numOfColors: Int) -> String {
		var result = ""
		for i in 1...numOfColors {
			if (result.characters.count > 0) {
				result += " "
			}
			
			if let finish = fixedFinishes[i] {
				result += String(finish.rawValue[finish.rawValue.startIndex])
			} else {
				result += PaintShop.GLOSS
			}
		}
		return result
	}
}