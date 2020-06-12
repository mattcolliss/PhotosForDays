//
//  PhotosCollectionViewController.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 12/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UIViewController {

    private var viewModel: PhotosCollectionViewModel

    init?(coder: NSCoder, viewModel: PhotosCollectionViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Must be created with a view model.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
