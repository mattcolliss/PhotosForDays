//
//  PhotoDetailsViewController.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit
import SDWebImage
import Combine

protocol PhotoDetailsViewControllerDelegate: class {
    func dismiss(photoDetailsViewController: PhotoDetailsViewController)
}

class PhotoDetailsViewController: UIViewController {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!

    weak var delegate: PhotoDetailsViewControllerDelegate?
    private var viewModel: PhotoDetailsViewModel
    private var cancellables = Set<AnyCancellable>()

    init?(coder: NSCoder, viewModel: PhotoDetailsViewModel) {
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

// MARK: - View
extension PhotoDetailsViewController {

    private func configureView() {

        photoImageView.sd_setImage(with: viewModel.photoUrl)

        titleLabel.text = viewModel.photoTitle

        viewModel.$photoScaleMode
            .assign(to: \.contentMode, on: photoImageView)
            .store(in: &cancellables)
    }

}

// MARK: - Actions
extension PhotoDetailsViewController {

    @IBAction func photoTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        viewModel.togglePhotoScaleMode()
    }

    @IBAction func doneButtonTapped() {
        viewModel.resetPhotoScaleMode()
        delegate?.dismiss(photoDetailsViewController: self)
    }

}
