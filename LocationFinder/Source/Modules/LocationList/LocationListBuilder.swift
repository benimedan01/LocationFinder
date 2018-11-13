//
//  LocationListBuilder.swift
//  LocationFinder
//
//  Created by Beniamin Medan on 13/11/2018.
//  Copyright © 2018 RebelDot. All rights reserved.
//

import UIKit

class LocationListBuilder {

    static func buildModule() -> UINavigationController {
        let locationListViewController = UIStoryboard(name: "LocationList", bundle: nil).instantiateInitialViewController() as! LocationListViewController
        let presenter = LocationListPresenter()
        locationListViewController.eventHandler = presenter
        presenter.display = locationListViewController

        let interactor = LocationListInteractor()
        presenter.interactor = interactor
        interactor.presenter = presenter

        let router = LocationListRouter()
        router.viewController = locationListViewController
        presenter.router = router

        let navigationController = UINavigationController(rootViewController: locationListViewController)

        return navigationController
    }
}
