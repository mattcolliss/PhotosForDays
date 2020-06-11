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
        //TODO: change this to my actual view controllers
        let vc = storyboard.instantiateInitialViewController()!
        vc.view.backgroundColor = .systemBlue
        let masterNav = UINavigationController(rootViewController: vc)
        
        let vc2 = storyboard.instantiateInitialViewController()!
        vc2.view.backgroundColor = .systemPurple
        let detailNav = UINavigationController(rootViewController: vc2);
        
        splitViewController.viewControllers = [masterNav, detailNav];
        
    }
    
}

extension Coordinator: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
