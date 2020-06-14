//
//  SelectDateViewController.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 11/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit
import Combine

// MARK: - SelectDateViewControllerDelegate
protocol SelectDateViewControllerDelegate: class {
    func didSelect(_ date: Date)
}

// MARK: - SelectDateViewController
class SelectDateViewController: UIViewController {

    weak var delegate: SelectDateViewControllerDelegate?
    private var viewModel: SelectDateViewModel
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet var hintLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var selectedDateLabel: UILabel!
    @IBOutlet var startButton: UIButton!

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

        title = viewModel.title

        hintLabel.text = viewModel.hintText

        datePicker.minimumDate = viewModel.minimumDate
        datePicker.maximumDate = viewModel.maximumDate
        datePicker.date = viewModel.selectedDate

        viewModel.formattedSelectedDateSubject
            .assign(to: \.text, on: selectedDateLabel)
            .store(in: &cancellables)

        startButton.setTitle(viewModel.startButtonTitle, for: .normal)

    }

}

// MARK: - Actions
extension SelectDateViewController {

    @IBAction func datePickerValueChanged(picker: UIDatePicker) {
        viewModel.dateSelected(picker.date)
    }

    @IBAction func startButtonTapped() {
        delegate?.didSelect(viewModel.selectedDate)
    }

}
