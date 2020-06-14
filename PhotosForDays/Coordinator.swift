//
//  Coordinator.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 11/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit

class Coordinator: NSObject {

    /// The root container view controller
    let splitViewController: UISplitViewController

    /// The storyboard containing all dispalyed view controllers in this coordinator
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    /// Custom animated transitioning for presenting the photo details view controller
    let photoDetailsAnimatedTransistioning = PhotoDetailsAnimatedTransistioning()

    init(_ splitViewController: UISplitViewController) {

        self.splitViewController = splitViewController
        super.init()

        splitViewController.loadViewIfNeeded()
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.delegate = self

        //Scaffold the initial view controllers for the splitViewController
        let selectDateViewModel = SelectDateViewModel()
        let selectDateViewController: SelectDateViewController = storyboard.instantiateViewController(identifier: "SelectDateViewController") { coder in
            return SelectDateViewController(coder: coder, viewModel: selectDateViewModel)
        }
        selectDateViewController.delegate = self

        //Placeholder details displayed in the splitViewController details until a date is selected
        let placeholderDetailsViewModel = PlaceholderDetailsViewModel()
        let placeholderViewController: PlaceholderDetailsViewController = storyboard.instantiateViewController(identifier: "PlaceholderDetailsViewController") { coder in
            return PlaceholderDetailsViewController(coder: coder, viewModel: placeholderDetailsViewModel)
        }

        let masterNav = UINavigationController(rootViewController: selectDateViewController)
        let detailNav = UINavigationController(rootViewController: placeholderViewController)
        splitViewController.viewControllers = [masterNav, detailNav]

    }

}

// MARK: - SelectDateViewControllerDelegate
extension Coordinator: SelectDateViewControllerDelegate {

    func didSelect(_ date: Date) {
        // Set the detail view controller to a new instance of the photos collection view for the slected date
        let photosCollectionViewModel = PhotosCollectionViewModel(date: date)
        let photosCollectionViewController: PhotosCollectionViewController = storyboard.instantiateViewController(identifier: "PhotosCollectionViewController") { coder in
            return PhotosCollectionViewController(coder: coder, viewModel: photosCollectionViewModel)
        }
        photosCollectionViewController.delegate = self

        let detailNav = UINavigationController(rootViewController: photosCollectionViewController)
        splitViewController.showDetailViewController(detailNav, sender: self)
    }

}

// MARK: - PhotosCollectionViewControllerDelegate
extension Coordinator: PhotosCollectionViewControllerDelegate {

    func didSelect(_ photo: Photo, withFrame frame: CGRect) {

        // Present the photo details view controller modally from the splitViewController
        let photoDetailsViewModel = PhotoDetailsViewModel(photo: photo)
        let photoDetailsViewController: PhotoDetailsViewController = storyboard.instantiateViewController(identifier: "PhotoDetailsViewController") { coder in
            return PhotoDetailsViewController(coder: coder, viewModel: photoDetailsViewModel)
        }
        photoDetailsViewController.delegate = self

        let detailNav = UINavigationController(rootViewController: photoDetailsViewController)
        detailNav.modalPresentationStyle = .fullScreen
        detailNav.transitioningDelegate = self
        photoDetailsAnimatedTransistioning.originFrame = frame
        photoDetailsAnimatedTransistioning.presenting = true
        splitViewController.present(detailNav, animated: true, completion: nil)

    }

}

// MARK: - PhotoDetailsViewControllerDelegate
extension Coordinator: PhotoDetailsViewControllerDelegate {

    func dismiss(photoDetailsViewController: PhotoDetailsViewController) {
        photoDetailsAnimatedTransistioning.presenting = false
        photoDetailsViewController.dismiss(animated: true)
    }

}

// MARK: - UIViewControllerTransitioningDelegate
extension Coordinator: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // check what we're presenting and return the appropriate animated transitioning
        if let navContorller = presented as? UINavigationController,
            navContorller.viewControllers.first is PhotoDetailsViewController {
            return photoDetailsAnimatedTransistioning
        } else {
            return nil
        }
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // check what we're dismissing and return the appropriate animated transitioning
        if let navContorller = dismissed as? UINavigationController,
            navContorller.viewControllers.first is PhotoDetailsViewController {
            return photoDetailsAnimatedTransistioning
        } else {
            return nil
        }
    }

}

// MARK: - UISplitViewControllerDelegate
extension Coordinator: UISplitViewControllerDelegate {

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }

}
