//
//  HomeView.swift
//  NYGallery
//
//  Created by Omar Albeik on 7/23/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class HomeView: UIView {

	lazy var fetchTopStoriesButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .white
		button.setTitle("Fetch Top Stories", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
		return button
	}()

	lazy var clearCacheButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .white
		button.setTitle("Clear Cache", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
		button.tintColor = .red
		return button
	}()

	lazy var buttonsStackView: UIStackView = {
		let view = UIStackView(arrangedSubviews: [fetchTopStoriesButton, clearCacheButton])
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
		view.alignment = .fill
		view.distribution = .fill
		view.spacing = 8
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
		backgroundColor = .white
		addSubview(buttonsStackView)
	}

	func setupLayout() {
		buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		buttonsStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}

}
