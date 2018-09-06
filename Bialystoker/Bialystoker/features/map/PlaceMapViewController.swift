//
//  PlaceMapViewController.swift
//  Bialystoker
//
//  Created by Marcin Lepicki on 06/09/2018.
//  Copyright © 2018 Marcin Łępicki. All rights reserved.
//

import UIKit
import MapKit

class PlaceMapViewController: BaseViewController, MKMapViewDelegate {

    // Injected
    var viewModel: PlaceMapViewModel!
    
    var selectedPlace: Place?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupViewModelBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.fetchPlaces()
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    private func setupViewModelBinding() {
        
        viewModel.showLoading.subscribe { [weak self] showLoading in
            if showLoading {
                self?.showProgressHud()
            } else {
                self?.hideProgressHud()
            }
        }
        
        viewModel.error.subscribe { [weak self] errorMessage in
            self?.showError(with: errorMessage)
        }
        
        viewModel.places.subscribe { [weak self] places in
            self?.updateDisplayedPlaces(with: places)
        }
    }
    
    private func updateDisplayedPlaces(with places: [Place]) {
        
        // remove old annotations except our location
        mapView.annotations.forEach { annotation in
            if !annotation.isKind(of: MKUserLocation.self) {
                self.mapView.removeAnnotation(annotation)
            }
        }

        places.forEach { place in
            let coordinate = CLLocationCoordinate2D(latitude: place.location.latitude, longitude: place.location.longitude)
            let annotation = PlaceAnnotation(place: place)
            annotation.coordinate = coordinate
            self.mapView.addAnnotation(annotation)
        }

        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "annotationView"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if #available(iOS 11.0, *) {
            if view == nil {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            }
            
            view?.displayPriority = .required
        } else {
            if view == nil {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            }
        }
        view?.annotation = annotation
        view?.canShowCallout = true
        view?.rightCalloutAccessoryView = UIButton(type: .infoLight)

        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let placeAnnotation = view.annotation as? PlaceAnnotation else { return }
        selectedPlace = placeAnnotation.place
        performSegue(withIdentifier: "showDetailsFromMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? PlaceDetailsViewController {
            detailsVC.place = self.selectedPlace
        }
    }

}
