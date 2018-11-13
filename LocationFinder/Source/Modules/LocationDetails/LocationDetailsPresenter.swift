//
//  LocationDetailsPresenter.swift
//  LocationFinder
//
//  Created by Beniamin Medan on 13/11/2018.
//  Copyright © 2018 RebelDot. All rights reserved.
//

import Foundation

protocol LocationDetailsEventHandler {
    func showLocationDetails()
}

protocol LocationDetailsPresenting: class {
    func retrievedLocationDetails(locationDetails: LocationDetails?, error: Error?)
}

class LocationDetailsPresenter: LocationDetailsEventHandler, LocationDetailsPresenting {

    weak var display: LocationDetailsDisplay?
    var interactor: (LocationDetailsBusinessLogic & LocationDetailsDataStore)!

    func showLocationDetails() {
        interactor.getLocationDetails()
    }

    func retrievedLocationDetails(locationDetails: LocationDetails?, error: Error?) {
        if locationDetails != nil {
            display?.display(locationDetails: locationDetails!, error: nil)
        } else {
            display?.showErrorAlert(message: error?.localizedDescription ?? "An unknown error has occurred", title: "Error", buttonText: "Ok")
        }
    }
}
