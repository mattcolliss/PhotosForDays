//
//  PhotosCollectionViewController.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 12/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit
import Combine

class PhotosCollectionViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!

    private var viewModel: PhotosCollectionViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Int, Photo>?

    private let itemsPerRow: CGFloat = 3
    private let minimumSpacing: CGFloat = 1

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
        setBindings()
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

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, photo) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell
            cell?.configure(with: photo, forIndexPath: indexPath)
            cell?.photoWidthConstraint.constant = self.itemWidth
            return cell
        }

    }

    private func setBindings() {

        viewModel.$photos
            .sink(receiveValue: self.applySnapshot)
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

    var itemWidth: CGFloat {
        let spacing = minimumSpacing * (itemsPerRow - 1)
        let availableWidth = collectionView.frame.size.width - spacing
        let widthPerItem = floor(availableWidth / itemsPerRow)
        return widthPerItem
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidth, height: itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if indexPath.item == viewModel.photos.count - 1
            && viewModel.morePhotosAvailable
            && !viewModel.fecthingPhotos {
            viewModel.fetchPhotos()
        }

    }

}
