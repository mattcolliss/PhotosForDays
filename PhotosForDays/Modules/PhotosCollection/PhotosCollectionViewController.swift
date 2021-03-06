//
//  PhotosCollectionViewController.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 12/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit
import Combine

// MARK: - PhotosCollectionViewControllerDelegate
protocol PhotosCollectionViewControllerDelegate: class {
    func didSelect(_ photo: Photo, forDate date: Date, withFrame frame: CGRect)
}

// MARK: - PhotosCollectionViewController
class PhotosCollectionViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var errorView: UIView!
    @IBOutlet var errorLabel: UILabel!

    weak var delegate: PhotosCollectionViewControllerDelegate?
    private var viewModel: PhotosCollectionViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>?

    init?(coder: NSCoder, viewModel: PhotosCollectionViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Must be created with a view model.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.fetchPhotos()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.reloadData()
    }

}

// MARK: - View
extension PhotosCollectionViewController {

    private func configureView() {

        title = viewModel.formattedDate

        // Make a diffableDataSource for the collection view
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, photo) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell
            cell?.configure(with: photo, forIndexPath: indexPath)
            cell?.photoWidthConstraint.constant = self.itemWidth
            return cell
        }

        // Update the diffableDataSource whenever the photos change
        viewModel.$photos
            .sink(receiveValue: self.applySnapshot)
            .store(in: &cancellables)

        // Show / hide the error banner depending on if we have an error message
        viewModel.$errorText
            .sink { [weak self] errorText in
                self?.errorLabel.text = errorText
                UIView.animate(withDuration: 0.75) {
                    self?.errorView.alpha = errorText == nil ? 0 : 1
                }
            }
            .store(in: &cancellables)

    }

    private func applySnapshot(_ photos: [Photo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Photo>()
        snapshot.appendSections([0])
        snapshot.appendItems(photos)
        dataSource?.apply(snapshot)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {

    /// The computed width for each item in the collection view
    private var itemWidth: CGFloat {
        let spacing = viewModel.minimumSpacing * (viewModel.itemsPerRow - 1)
        let availableWidth = collectionView.frame.size.width - spacing
        let widthPerItem = floor(availableWidth / viewModel.itemsPerRow)
        return widthPerItem
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidth, height: itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // If we've reached the bottom of the collection view, request more photos from the view model if availble
        if indexPath.item == viewModel.photos.count - 1
            && viewModel.morePhotosAvailable
            && !viewModel.fecthingPhotos {
            viewModel.fetchPhotos()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let selectedCell = collectionView.cellForItem(at: indexPath),
            let selectedCellOrigin = selectedCell.superview?.convert(selectedCell.frame.origin, to: nil) else {
            return
        }

        let selectedCellFrame = CGRect(origin: selectedCellOrigin, size: CGSize(width: itemWidth, height: itemWidth))

        let photo = viewModel.photos[indexPath.item]
        delegate?.didSelect(photo, forDate: viewModel.date, withFrame: selectedCellFrame)
    }

}
