//
//  CommonRoutes.swift
//  Countries
//
//  Created by Ivan Redreev on 10.10.2023.
//

import UIKit

protocol AlertsRoute {
    func showCancelAlert(title: String?, message: String?)
}

extension AlertsRoute where Self: UIViewController {
    func showCancelAlert(title: String?, message: String?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true)
    }
}

protocol FullscreenLoaderRoute {
    func showFullscreenLoader()
    func hideFullscreenLoader()
}

extension FullscreenLoaderRoute where Self: UIViewController {
    
    func showFullscreenLoader() {
        let loaderView = UIView()
        loaderView.backgroundColor = .clear
        loaderView.tag = 777_777
        loaderView.alpha = 0
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .blue
        activity.translatesAutoresizingMaskIntoConstraints = false
        loaderView.addSubview(activity)
        view.addSubview(loaderView)
        
        [activity.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor),
         activity.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor),
         loaderView.topAnchor.constraint(equalTo: view.topAnchor),
         loaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
         loaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
         loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)].forEach { $0.isActive = true }
        
        view.setNeedsLayout()
        activity.startAnimating()
        
        UIView.animate(withDuration: 0.1) {
            loaderView.alpha = 1
        }
    }
    
    func hideFullscreenLoader() {
        guard let loaderView = view.viewWithTag(777_777) else {
            return
        }
        UIView.animate(withDuration: 0.2) {
            loaderView.alpha = 0
        }
        loaderView.removeFromSuperview()
    }
}
