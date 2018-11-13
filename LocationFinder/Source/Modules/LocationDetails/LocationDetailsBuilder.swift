//
//  LocationDetailsBuilder.swift
//  LocationFinder
//
//  Created by Beniamin Medan on 13/11/2018.
//  Copyright © 2018 RebelDot. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailsBuilder {

    static func buildModule(location: MKLocalSearchCompletion) -> UIViewController {

        let storyboard = UIStoryboard(name: "LocationDetails", bundle: nil)
        let locationDetailsViewController = storyboard.instantiateInitialViewController() as! LocationDetailsViewController

        let interactor = LocationDetailsInteractor()
        let presenter = LocationDetailsPresenter()
        locationDetailsViewController.eventHandler = presenter
        presenter.interactor = interactor
        presenter.display = locationDetailsViewController
        interactor.presenter = presenter
        interactor.location = location

        return locationDetailsViewController
    }
}
