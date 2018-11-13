//
//  LocationListPresenter.swift
//  LocationFinder
//
//  Created by Beniamin Medan on 13/11/2018.
//  Copyright © 2018 RebelDot. All rights reserved.
//

import MapKit

enum LocationListPresentingModel {
    struct Location {
        let title: String
        let subtitle: String
    }
}

protocol LocationListEventHandling {
    func showLocations(searchText: String)
    func selectLocation(index: Int)
}

protocol LocationListPresenting: class {
    func retrievedLocations(locations: [Location], error: Error?)
}

class LocationListPresenter {
    weak var display: LocationListDisplay?
    var interactor: (LocationListBusinessLogic & LocationListDataStore)!
    var router: LocationListRoutingLogic!
}

extension LocationListPresenter: LocationListPresenting {
    func retrievedLocations(locations: [Location], error: Error?) {
        if error == nil {
            display?.showLocations(locations: locations)
        } else {
            display?.showErrorAlert(message: error?.localizedDescription ?? "An unknown error has occurred", title: "Error", buttonText: "Ok")
        }
    }
}

extension LocationListPresenter: LocationListEventHandling {

    func showLocations(searchText: String) {
        interactor.getLocations(searchText: searchText)
    }

    func selectLocation(index: Int) {
        interactor.selectLocation(index: index)
        if let location = interactor.selectedCompletionLocation {
            router.routeToLocationDetails(location: location)
        }
    }
}

