//
//  BaseResponse.swift
//  NYGallery
//
//  Created by Omar Albeik on 7/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {

	let results: [T]
	let message: String?

}
