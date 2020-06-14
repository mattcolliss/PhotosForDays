//
//  Theming.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 14/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation
import UIKit

func applyGloablTheme() {

    let titleTextAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor(named: "PrimaryLabel") ?? UIColor.systemGray
    ]

    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.titleTextAttributes = titleTextAttributes
    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance

    UINavigationBar.appearance().tintColor = UIColor(named: "PrimaryTint")

}
