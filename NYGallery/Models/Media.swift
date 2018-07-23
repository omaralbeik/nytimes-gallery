//
//  Media.swift
//  NYGallery
//
//  Created by Omar Albeik on 7/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

struct Media: Codable {

	enum MediaFormat: String, Codable {
		case thumbStandard = "Standard Thumbnail"
		case thumbLarge = "thumbLarge"
		case normal = "Normal"
		case mediumThreeByTwo210 = "mediumThreeByTwo210"
		case superJumbo = "superJumbo"
	}

	let url: URL
	let format: MediaFormat

}
