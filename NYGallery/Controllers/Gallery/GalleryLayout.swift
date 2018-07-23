//
//  GalleryLayout.swift
//  NYGallery
//
//  Created by Omar Albeik on 7/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class GalleryLayout: UICollectionViewFlowLayout {

	var numberOfItemsInRow = 3 {
		didSet {
			prepare()
		}
	}

	override func prepare() {
		super.prepare()

		scrollDirection = .vertical

		guard let view = collectionView else { return }
		let availableWidth = view.bounds.size.width

		minimumInteritemSpacing = 5
		sectionInset = .init(top: minimumInteritemSpacing, left: 0, bottom: minimumInteritemSpacing, right: 0)
		if #available(iOS 11.0, *) {
			sectionInsetReference = .fromSafeArea
		}

		let netWidth = availableWidth - (CGFloat(numberOfItemsInRow) * minimumInteritemSpacing)

		let cellWidth = netWidth / CGFloat(numberOfItemsInRow)
		itemSize = CGSize(width: cellWidth, height: cellWidth)
	}

}
