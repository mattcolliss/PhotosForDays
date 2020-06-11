//
//  SelectDateViewController.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 11/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit

class SelectDateViewController: UIViewController {

    private var viewModel: SelectDateViewModel
    
    init?(coder: NSCoder, viewModel: SelectDateViewModel) {
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
