//
//  LocationListInteractor.swift
//  LocationFinder
//
//  Created by Beniamin Medan on 13/11/2018.
//  Copyright © 2018 RebelDot. All rights reserved.
//

import MapKit

protocol LocationListBusinessLogic {
    func getLocations(searchText: String)
    func selectLocation(index: Int)
}

protocol LocationListDataStore {
    var selectedCompletionLocation: MKLocalSearchCompletion? { get }
}

class LocationListInteractor: NSObject, MKLocalSearchCompleterDelegate, LocationListBusinessLogic, LocationListDataStore {

    weak var presenter: LocationListPresenting?

    var completer: MKLocalSearchCompleter?

    private var locationList = [Location]()
    private var locationCompletionList = [MKLocalSearchCompletion]() {
        didSet {
            self.locationList.removeAll()
            for locationCompletion in locationCompletionList {
                let location = Location(title: locationCompletion.title, subtitle: locationCompletion.subtitle)
                self.locationList.append(location)
            }
        }
    }

    private var selectedLocationIndex: Int?

    func getLocations(searchText: String) {
        if searchText == "" {
            self.locationCompletionList.removeAll()
            presenter?.retrievedLocations(locations: [], error: nil)
        } else {
            if self.completer == nil {
                completer = MKLocalSearchCompleter()
                completer?.delegate = self
            }
            completer!.queryFragment = searchText
        }
    }

    func selectLocation(index: Int) {
        guard index < locationCompletionList.count else {
            assert(true, "Index out of bounds")
            return
        }

        selectedLocationIndex = index
    }

    var selectedCompletionLocation: MKLocalSearchCompletion? {
        guard let index = selectedLocationIndex else {
            return nil
        }
        return locationCompletionList[index]
    }

    // MARK: MKLocalSearchCompleter delegate methods
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.locationCompletionList = completer.results
        presenter?.retrievedLocations(locations: locationList, error: nil)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        presenter?.retrievedLocations(locations: [], error: error)
    }
}
