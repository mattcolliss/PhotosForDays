//
//  Coordinator.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 11/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import UIKit

class Coordinator {
    
    let splitViewController: UISplitViewController
    let storyboard = UIStoryboard(name: "Main", bundle: nil);
    
    init(_ splitViewController: UISplitViewController) {
        
        self.splitViewController = splitViewController
        splitViewController.loadViewIfNeeded()
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.delegate = self
        
        //Scaffold the initial view controllers for the splitViewController
        let selectDateViewModel = SelectDateViewModel()
        let selectDateViewController: SelectDateViewController = storyboard.instantiateViewController(identifier: "SelectDateViewController") { coder in
            return SelectDateViewController(coder: coder, viewModel: selectDateViewModel)
        }
        selectDateViewController.delegate = self
        
        let masterNav = UINavigationController(rootViewController: selectDateViewController)
        
        let vc = UIViewController()
        vc.view.backgroundColor = .systemPurple
        let detailNav = UINavigationController(rootViewController: vc);
        
        splitViewController.viewControllers = [masterNav, detailNav];
        
    }
    
}

// MARK: - SelectDateViewControllerDelegate
extension Coordinator: SelectDateViewControllerDelegate {
    
    func didSelect(_ date: Date) {
        // TODO: make a new details view controller ad add it to the split view
        let vc = UIViewController()
        vc.view.backgroundColor = .systemRed
        let detailNav = UINavigationController(rootViewController: vc);
        splitViewController.showDetailViewController(detailNav, sender: self)
    }
    
}

// MARK: - UISplitViewControllerDelegate
extension Coordinator: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
