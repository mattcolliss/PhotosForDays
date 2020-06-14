//
//  PlaceholderDetailsViewController.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 14/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit

class PlaceholderDetailsViewController: UIViewController {

    private var viewModel: PlaceholderDetailsViewModel

    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var hintLabel: UILabel!

    init?(coder: NSCoder, viewModel: PlaceholderDetailsViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Must be created with a view model.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

}

// MARK: View
extension PlaceholderDetailsViewController {

    private func configureView() {
        iconImageView.image = viewModel.icon
        hintLabel.text = viewModel.hintText
    }

}
