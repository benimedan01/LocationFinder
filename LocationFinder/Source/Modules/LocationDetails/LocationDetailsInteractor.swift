//
//  LocationDetailsInteractor.swift
//  LocationFinder
//
//  Created by Beniamin Medan on 13/11/2018.
//  Copyright © 2018 RebelDot. All rights reserved.
//

import Foundation
import MapKit

protocol LocationDetailsBusinessLogic {
    func getLocationDetails()
}

protocol LocationDetailsDataStore {
    var location: MKLocalSearchCompletion? { get set }
}

class LocationDetailsInteractor: LocationDetailsBusinessLogic, LocationDetailsDataStore {
    weak var presenter: LocationDetailsPresenting?
    var location: MKLocalSearchCompletion?

    func getLocationDetails() {

        let searchRequest = MKLocalSearch.Request(completion: location!)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let error = error {
                self.presenter?.retrievedLocationDetails(locationDetails: nil, error: error)
            } else {
                let coordinate = response?.mapItems[0].placemark.coordinate

                let locationDetails = LocationDetails( name: self.location!.title,
                                                       address: self.location!.subtitle,
                                                       latitude: "\(String(describing: coordinate!.latitude))",
                                                       longitude: "\(String(describing: coordinate!.longitude))")

                self.presenter?.retrievedLocationDetails(locationDetails: locationDetails, error: nil)
            }
        }
    }
}
