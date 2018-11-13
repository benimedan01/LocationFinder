//
//  LocationDetailsViewController.swift
//  LocationFinder
//
//  Created by Beniamin Medan on 13/11/2018.
//  Copyright © 2018 RebelDot. All rights reserved.
//

import UIKit

protocol LocationDetailsDisplay: class {
    func display(locationDetails: LocationDetails, error: Error?)
    func showErrorAlert(message: String, title: String?, buttonText: String)
}


class LocationDetailsViewController: UIViewController, LocationDetailsDisplay {

    // MARK: Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var locationLatitudeLabel: UILabel!
    @IBOutlet weak var locationLongitudeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var eventHandler: LocationDetailsEventHandler?

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Location Details"
        getLocationDetails()
    }

    func getLocationDetails() {
        activityIndicator.startAnimating()
        eventHandler?.showLocationDetails()
    }

    func display(locationDetails: LocationDetails, error: Error?) {
        activityIndicator.stopAnimating()
        locationNameLabel.text = locationDetails.name
        locationAddressLabel.text = locationDetails.address
        locationLatitudeLabel.text = locationDetails.latitude
        locationLongitudeLabel.text = locationDetails.longitude
    }

    func showErrorAlert(message: String, title: String?, buttonText: String) {
        activityIndicator.stopAnimating()
        UIAlertController.showOneButtonAlert(on: self, alertInput: AlertInput(message: message, title: title, actionText: buttonText))
    }
}
