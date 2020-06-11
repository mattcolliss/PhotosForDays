//
//  SelectDateViewController.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 11/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit
import Combine

class SelectDateViewController: UIViewController {

    private var viewModel: SelectDateViewModel
    private var cancellables = Set<AnyCancellable>()
    
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
        setBindings()
    }
    
}

// MARK: - View
extension SelectDateViewController {
    
    private func configureView() {
        datePicker.maximumDate = Date()
        datePicker.date = viewModel.selectedDate
    }
    
    private func setBindings() {
        viewModel.formattedSelectedDateSubject
            .print()
            .assign(to: \.text, on: selectedDateLabel)
            .store(in: &cancellables)
    }
    
}

// MARK: - Actions
extension SelectDateViewController {
    
    @IBAction func datePickerValueChanged(picker: UIDatePicker) {
        viewModel.dateSelected(picker.date)
    }
    
}
