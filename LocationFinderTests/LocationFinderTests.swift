//
//  LocationFinderTests.swift
//  LocationFinderTests
//
//  Created by Beniamin Medan on 13/11/2018.
//  Copyright © 2018 RebelDot. All rights reserved.
//

import XCTest
@testable import LocationFinder

class LocationFinderTests: XCTestCase {

    var testViewController: LocationListViewController!

    override func setUp() {
        let storyboard: UIStoryboard = UIStoryboard(name: "LocationList", bundle: nil)

        testViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? LocationListViewController

        //load view hierarchy
        _ = testViewController.view
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSUT_CanBeInstantiated() {

        XCTAssertNotNil(testViewController)
    }

    // MARK: - SearchBar

    func testSUT_HasSearchBar() {

        XCTAssertNotNil(testViewController.searchBar)
    }

    func testSUT_ShouldSetSearchBarDelegate() {
        XCTAssertNotNil(self.testViewController.searchBar.delegate)
    }

    func testSUT_ConformsToSearchBarDelegateProtocol() {
        XCTAssert(testViewController.conforms(to: UISearchBarDelegate.self))
    }

    func testSUT_CanProperlyDisplay_CityState_AutoSuggestionsInTableView_AfterSearchTextChanges() {

        // sample of items
        let location0 = Location(title:"Bucharest", subtitle:"Bucharest, Romania")
        let location1 = Location(title:"Bistrita", subtitle:"Bistrita, Romania")
        let location2 = Location(title:"Birmingham", subtitle:"Birmingham, England")

        testViewController.locations = [location0, location1, location2]

        // simulate user typing in Search text and confirm results ...

        testViewController.searchBar(testViewController.searchBar, textDidChange: "B")
        XCTAssertEqual(testViewController.locations.count, 3)
        XCTAssertEqual(testViewController.locations[0], location0)
        XCTAssertEqual(testViewController.locations[1], location1)
        XCTAssertEqual(testViewController.locations[2], location2)
    }

}
