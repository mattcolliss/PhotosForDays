//
//  PhotoDetailsAnimatedTransistioning.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation
import UIKit

class PhotoDetailsAnimatedTransistioning: NSObject, UIViewControllerAnimatedTransitioning {

    let duration = 0.25
    var presenting = true
    var originFrame = CGRect.zero

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        if presenting {
            animatePresentation(using: transitionContext)
        } else {
            animateDismissing(using: transitionContext)
        }

    }

    private func animatePresentation(using transitionContext: UIViewControllerContextTransitioning) {

        // get both vcs and take snapshot at the origin frame
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = fromVC.view.resizableSnapshotView(from: originFrame, afterScreenUpdates: true, withCapInsets: .zero) else {
                return
        }

        // set the initial state - the snapshot at its origal size with the destunation view hidden
        let containerView = transitionContext.containerView
        snapshot.frame = originFrame
        containerView.addSubview(snapshot)
        containerView.addSubview(toVC.view)
        toVC.view.isHidden = true

        // animate the snapshot size up to the full size
        UIView.animate(withDuration: duration, animations: {
            snapshot.frame = self.calculateApectFillFrame(for: transitionContext.finalFrame(for: toVC))
        }, completion: { _ in
            toVC.view.isHidden = false
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })

    }

    private func animateDismissing(using transitionContext: UIViewControllerContextTransitioning) {

        // get the collection vc and take snapshot at the origin frame
        guard let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = toVC.view.resizableSnapshotView(from: originFrame, afterScreenUpdates: true, withCapInsets: .zero) else {
                return
        }

        // set the initial state - the snapshot at fullsize over the top of the collection
        let containerView = transitionContext.containerView
        snapshot.frame = calculateApectFillFrame(for: transitionContext.finalFrame(for: toVC))
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)

        // animate the snapshot down to its original frame
        UIView.animate(withDuration: duration, animations: {
            snapshot.frame = self.originFrame
        }, completion: { _ in
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })

    }

    /// calculates the full frame of the image when displayed at full size aspectFill scale type in the given view controller's frame - ie. what the full frame of the image would be if all of it could be seen
    private func calculateApectFillFrame(for viewControllerFrame: CGRect) -> CGRect {
        // TODO: fix this as it isn't quite correct
        var frame = viewControllerFrame
        let largestDimension = max(frame.width, frame.height)
        frame = frame.insetBy(dx: (frame.width - largestDimension) / 2, dy: (frame.height - largestDimension) / 2)
        return frame
    }

}
