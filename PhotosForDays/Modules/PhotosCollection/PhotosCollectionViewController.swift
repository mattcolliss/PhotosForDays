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

}

// MARK: - View
extension PhotosCollectionViewController {

    private func configureView() {

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, photo) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell
            cell?.configure(with: photo, forIndexPath: indexPath)
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = minimumSpacing * (itemsPerRow - 1)
        let availableWidth = collectionView.frame.size.width - spacing
        let widthPerItem = floor(availableWidth / itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

}
