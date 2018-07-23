//
//  GalleryCell.swift
//  NYGallery
//
//  Created by Omar Albeik on 7/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class GalleryCell: UICollectionViewCell {

	lazy private var imageView: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .black
		view.tintColor = .white
		view.contentMode = .scaleAspectFill
		return view
	}()

	lazy private var loadingIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.color = .white
		return view
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupViews()
		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		setupViews()
		setupLayout()
	}

	func setupViews() {
		backgroundColor = .black

		addSubview(imageView)
		addSubview(loadingIndicator)
	}

	func setupLayout() {
		imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

		loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}

	func setImage(_ image: UIImage?) {
		imageView.image = image ?? #imageLiteral(resourceName: "icon_no_photo")
	}

	func setLoading(_ loading: Bool) {
		imageView.isHidden = loading
		loading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
	}

}
