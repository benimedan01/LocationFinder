//
//  UIAlertController+Extensions.swift
//  LocationFinder
//
//  Created by Beniamin Medan on 13/11/2018.
//  Copyright © 2018 RebelDot. All rights reserved.
//

import UIKit

struct AlertInput {
    let title: String?
    let message: String
    let actionText: String
    let actionCompletion: (() -> Void)?

    init(message: String, title: String? = nil, actionText: String, actionCompletion: (() -> Void)? = nil) {
        self.message = message
        self.title = title
        self.actionText = actionText
        self.actionCompletion = actionCompletion
    }
}

extension UIAlertController {

    static func showOneButtonAlert(on vc: UIViewController, alertInput: AlertInput, presentationCompletion: (() -> Void)? = nil) {
        let controller = UIAlertController(title: alertInput.title, message: alertInput.message, preferredStyle: .alert)
        let action = UIAlertAction(title: alertInput.actionText, style: .default) { _ in
            alertInput.actionCompletion?()
        }
        controller.addAction(action)
        vc.present(controller, animated: true, completion: presentationCompletion)
    }
}
