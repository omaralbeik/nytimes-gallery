//
//  API.swift
//  NYGallery
//
//  Created by Omar Albeik on 7/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

typealias TopStoriesResponse = (_ stories: [Story], _ error: Error?) -> Void

final class API {

	// New York Times API key
	// get yours at https://developer.nytimes.com/signup
	static let key = "d9f8220535b6434baeef95559bc4f487"

	static var url = URL(string: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(key)")!

	static let defaultSession = URLSession(configuration: .default)
	static var dataTask: URLSessionDataTask?

	static func fetchTopStories(_ completion: @escaping TopStoriesResponse) {
		dataTask = defaultSession.dataTask(with: url) { data, _, error in
			defer { self.dataTask = nil }

			guard let aData = data else {
				completion([], error)
				return
			}

			do {
				let baseResponse = try JSONDecoder().decode(BaseResponse<Story>.self, from: aData)
				completion(baseResponse.results, nil)
			} catch {
				completion([], error)
			}

		}

		dataTask?.resume()
	}

	static func clearResponsesCache() {
		URLCache.shared.removeAllCachedResponses()
	}

}
