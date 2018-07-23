//
//  Story.swift
//  NYGallery
//
//  Created by Omar Albeik on 7/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

struct Story: Codable {

	let title: String
	let url: URL
	let multimedia: [Media]

	var thumbUrl: URL? {
		if let url = multimedia.first(where: { $0.format == .thumbStandard })?.url {
			return url
		}

		if let url = multimedia.first(where: { $0.format == .thumbLarge })?.url {
			return url
		}

		if let url = multimedia.first(where: { $0.format == .normal })?.url {
			return url
		}

		if let url = multimedia.first(where: { $0.format == .mediumThreeByTwo210 })?.url {
			return url
		}

		if let url = multimedia.first(where: { $0.format == .superJumbo })?.url {
			return url
		}

		return nil
	}

	var cachedImage: UIImage? {
		guard let aUrl = thumbUrl else { return nil }
		return ImagesCache.image(forUrl: aUrl)
	}

}
