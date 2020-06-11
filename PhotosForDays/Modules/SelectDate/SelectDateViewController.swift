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
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var selectedDateLabel: UILabel!
    
    init?(coder: NSCoder, viewModel: SelectDateViewModel) {
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
extension SelectDateViewController {
    
    private func configureView() {
        datePicker.maximumDate = Date()
        datePicker.date = viewModel.selectedDate
    }
    
}

// MARK: - Actions
extension SelectDateViewController {
    
    @IBAction func datePickerValueChanged(picker: UIDatePicker) {
        viewModel.dateSelected(picker.date)
    }
    
}
