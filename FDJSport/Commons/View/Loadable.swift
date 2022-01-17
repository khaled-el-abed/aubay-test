//
//  Loadable.swift
//  FDJSport
//
//  Created by Khaled ElAbed perso on 17/01/2022.
//

import Foundation
import UIKit

fileprivate struct Constants {
    /// an arbitrary tag id for the loading view, so it can be retrieved later without keeping a reference to it
    fileprivate static let loadingViewTag = 1234
}

protocol Loadable {
    func showLoadingView()
    func hideLoadingView()
}



/// Default implementation for UIViewController
extension Loadable where Self: UIViewController {

    func showLoadingView() {
        let loadingView = LoadingView()
        view.addSubview(loadingView)

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.animate()

        loadingView.tag = Constants.loadingViewTag
    }

    func hideLoadingView() {
        view.subviews.forEach { subview in
            if subview.tag == Constants.loadingViewTag {
                subview.removeFromSuperview()
            }
        }
    }
}

final class LoadingView: UIView {
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        return activity
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        activityIndicatorView.color = .white
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        layer.cornerRadius = 5

        if activityIndicatorView.superview == nil {
            addSubview(activityIndicatorView)

            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            activityIndicatorView.startAnimating()
        }
    }

    public func animate() {
        activityIndicatorView.startAnimating()
    }
}

