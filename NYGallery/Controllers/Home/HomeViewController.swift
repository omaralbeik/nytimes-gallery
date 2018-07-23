//
//  HomeViewController.swift
//  NYGallery
//
//  Created by Omar Albeik on 7/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

	override func loadView() {
		view = HomeView()
	}

	var homeView: HomeView {
		return view as! HomeView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		homeView.fetchTopStoriesButton.addTarget(self, action: #selector(didTapFetchTopStoriesButton(_:)), for: .touchUpInside)
		homeView.clearCacheButton.addTarget(self, action: #selector(didTapClearCacheButton), for: .touchUpInside)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationItem.title = "Home"
	}

}

// MARK: - Actions
private extension HomeViewController {

	@objc
	func didTapFetchTopStoriesButton(_ button: UIButton) {
		button.isEnabled = false

		API.fetchTopStories { [unowned self] (stories, error) in
			DispatchQueue.main.async {
				button.isEnabled = true
			}

			if let anError = error {
				self.presentAlert(error: anError)
				return
			}

			self.showGalleryViewController(stories: stories)
		}
	}

	@objc
	func didTapClearCacheButton() {
		API.clearResponsesCache()
		ImagesCache.clear()
	}

}

// MARK: - Helpers
private extension HomeViewController {

	@discardableResult
	func showGalleryViewController(stories: [Story]) -> GalleryViewController {
		let galleryViewController = GalleryViewController(stories: stories)
		DispatchQueue.main.async { [unowned self] in
			self.navigationController?.pushViewController(galleryViewController, animated: true)
		}
		return galleryViewController
	}

	@discardableResult
	func presentAlert(error: Error) -> UIAlertController {
		let alert = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default)
		alert.addAction(okAction)

		DispatchQueue.main.async { [unowned self] in
			self.present(alert, animated: true, completion: nil)
		}

		return alert
	}

}
