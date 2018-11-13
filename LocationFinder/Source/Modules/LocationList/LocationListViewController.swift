//
//  LocationListViewController.swift
//  LocationFinder
//
//  Created by Beniamin Medan on 13/11/2018.
//  Copyright © 2018 RebelDot. All rights reserved.
//

import UIKit

protocol LocationListDisplay: class {
    func showLocations(locations: [Location])
    func showErrorAlert(message: String, title: String?, buttonText: String)
}

class LocationListViewController: UIViewController, LocationListDisplay {

    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var eventHandler: LocationListEventHandling?
    var locations = [Location]() {
        didSet{
            self.locationsTableView.reloadData()
        }
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        searchBar.delegate = self

        self.title = "Location Finder"
    }

    // MARK: Actions
    func showLocations(locations: [Location]) {
        self.locations = locations
        activityIndicator.stopAnimating()
    }

    func showErrorAlert(message: String, title: String?, buttonText: String) {
        activityIndicator.stopAnimating()
        self.locations.removeAll()
        UIAlertController.showOneButtonAlert(on: self, alertInput: AlertInput(message: message, title: title, actionText: buttonText))
    }
}

// MARK: Search bar delegate methods
extension LocationListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        activityIndicator.startAnimating()
        eventHandler?.showLocations(searchText: searchText)
    }
}

// MARK: Tableview data source methods
extension LocationListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = locations[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = location.title
        cell.detailTextLabel?.text = location.subtitle
        return cell
    }
}

// MARK: Tableview delegate methods
extension LocationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        eventHandler?.selectLocation(index: indexPath.row)
    }
}
