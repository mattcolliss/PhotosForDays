//
//  PhotoCollectionViewCell.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "PhotoCollectionViewCell"

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photoWidthConstraint: NSLayoutConstraint!

    func configure(with photo: Photo, forIndexPath indexPath: IndexPath) {
        photoImageView.sd_setImage(with: photo.url)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.sd_cancelCurrentImageLoad()
        photoImageView.image = nil
    }

}
