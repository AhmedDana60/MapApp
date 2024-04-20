//
//  LocationsViewModel.swift
//  SwiftfulMapApp
//
//  Created by Ahmed Dana Mohammed on 3/13/24.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    //All lodade locations
    @Published var locations: [Location]
    
    //currenct location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    //Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
   
    // Show list of locations
    @Published var showLocationsList: Bool = false
    
    //show location detail via sheet
    @Published var sheetLocation: Location? = nil 
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location : Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates, span: mapSpan
            )
        }
        
        
    }
    
     func toggleLocationsList() {
        withAnimation(.easeInOut){
            showLocationsList.toggle()
        }
    }
    func showNextLocation(location : Location) {
        withAnimation(.easeInOut){
            mapLocation = location
            showLocationsList = false
        }
    }
    func nextButtonPressed() {
        //Get the current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current index in locations array! Should never happen.")
            return
        }
        // Check if the currentIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            //Next index is not Valid!!
            // Restart from 0
            guard let firstlocation = locations.first else { return }
            showNextLocation(location: firstlocation)
            return
        }
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
