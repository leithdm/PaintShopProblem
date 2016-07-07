//
//  Customer.swift
//  PaintShopProblem
//
//  Created by Darren Leith on 06/07/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import Foundation

final class Customer: Comparable {
	
	var paintPreferences = [Paint]()

	func addPaintPreference(color: Int, finish: Finish) {
		let paint = Paint(color: color, finish: finish)
		paintPreferences.append(paint)
	}
}


//MARK: custom comparator
func <(lhs: Customer, rhs: Customer) -> Bool {
	return lhs.paintPreferences.count < rhs.paintPreferences.count
}

func ==(lhs: Customer, rhs: Customer) -> Bool {
	return lhs.paintPreferences.count == rhs.paintPreferences.count
}