//
//  PhotoCollectionViewCell.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "PhotoCollectionViewCell"

    @IBOutlet var photoImageView: UIImageView!

    func configure(with photo: Photo, forIndexPath indexPath: IndexPath) {
    
    }

}
