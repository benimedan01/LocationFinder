//
//  LocationListRouter.swift
//  LocationFinder
//
//  Created by Beniamin Medan on 13/11/2018.
//  Copyright © 2018 RebelDot. All rights reserved.
//

import UIKit
import MapKit

protocol LocationListRoutingLogic {
    func routeToLocationDetails(location: MKLocalSearchCompletion)
}

class LocationListRouter: LocationListRoutingLogic {
        weak var viewController: UIViewController?

        func routeToLocationDetails(location: MKLocalSearchCompletion) {
        let detailsVC = LocationDetailsBuilder.buildModule(location: location)
        let navigationController = viewController?.navigationController
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
