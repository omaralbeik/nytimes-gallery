//
//  GalleryViewController.swift
//  NYGallery
//
//  Created by Omar Albeik on 7/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit
import SafariServices

final class GalleryViewController: UIViewController {

	var stories: [Story] = []
	private let cellReuseIdentifier = "StoryCell"

	convenience init(stories: [Story]) {
		self.init()

		self.stories = stories
	}

	override func loadView() {
		view = GalleryView(frame: UIScreen.main.bounds, collectionViewLayout: GalleryLayout())
	}

	var galleryView: GalleryView {
		return view as! GalleryView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		galleryView.register(GalleryCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
		galleryView.dataSource = self
		galleryView.delegate = self

		if #available(iOS 10.0, *) {
			galleryView.prefetchDataSource = self
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationItem.title = "Gallery"
	}

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		guard let layout = galleryView.galleryLayout else { return }
		if size.width > size.height {
			layout.numberOfItemsInRow = 5
		} else {
			layout.numberOfItemsInRow = 3
		}
	}

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching
extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return stories.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! GalleryCell

		let story = stories[indexPath.item]
		if let image = story.cachedImage {
			cell.setImage(image)
		} else {
			downloadImage(withUrl: story.thumbUrl, for: cell)
		}
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let story = stories[indexPath.item]
		let webViewController = SFSafariViewController(url: story.url)
		present(webViewController, animated: true)
	}

	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		for indexPath in indexPaths {
			guard let url = stories[indexPath.item].thumbUrl else { continue }
			if ImagesCache.image(forUrl: url) != nil { continue }
			downloadImage(withUrl: url)
		}
	}

}

// MARK: - Helpers
private extension GalleryViewController {

	func downloadImage(withUrl url: URL?, for cell: GalleryCell? = nil) {
		guard let aUrl = url else {
			cell?.setImage(nil)
			return
		}

		cell?.setLoading(true)
		API.dataTask = API.defaultSession.dataTask(with: aUrl) { (data, _, _) in
			defer { API.dataTask = nil }

			DispatchQueue.main.async {
				cell?.setLoading(false)
			}

			guard let aData = data else { return }

			ImagesCache.saveImage(data: aData, forUrl: aUrl)

			DispatchQueue.main.async {
				cell?.setImage(UIImage(data: aData))
			}
		}

		API.dataTask?.resume()
	}

}
