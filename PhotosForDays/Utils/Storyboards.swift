//
//  Storyboards.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 14/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation
import UIKit

enum Storyboard: String {
    case main = "Main"
}

extension UIStoryboard {

    convenience init(_ name: Storyboard) {
        self.init(name: name.rawValue, bundle: nil)
    }

    /// Convenience instantiation of viewControllers where the StoryboardID is set to the type name of the view controller
    func instantiateViewController<T: UIViewController>(creator: ((NSCoder) -> T?)?) -> T {
        guard let name = NSStringFromClass(T.self).components(separatedBy: ".").last else {
            fatalError("Could not find view controller called " + String(describing: T.self))
        }
        return instantiateViewController(identifier: name, creator: creator)
    }

}
