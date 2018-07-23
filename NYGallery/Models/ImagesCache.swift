//
//  ImagesCache.swift
//  NYGallery
//
//  Created by Omar Albeik on 7/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class ImagesCache {

	private static var cache: [URL: Data] = [:]

	static func image(forUrl url: URL) -> UIImage? {
		guard let data = cache[url] else { return nil }
		return UIImage(data: data)
	}

	static func saveImage(data: Data?, forUrl url: URL) {
		cache[url] = data
	}

	static func clear() {
		cache.removeAll()
	}

}
