//
//  Finish.swift
//  PaintShopProblem
//
//  Created by Darren Leith on 06/07/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import Foundation

enum Finish: String {
	case Gloss
	case Matte
	
	static func parseFinish(stringFinish: String) -> Finish? {
	
		switch stringFinish {
		case "M":
			return Finish.Matte
		case "G":
			return Finish.Gloss
		default:
			return nil
		}
	}
}