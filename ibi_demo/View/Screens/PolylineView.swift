//
//  PolylineView.swift
//  ibi_demo
//
//  Created by WY on 2021/6/26.
//

import Foundation
import MapKit
import SwiftUI

struct PolylineView: UIViewRepresentable{

    // MARK: Properties
    //var polylineCoords: [CLLocationCoordinate2D] = []
    let region: MKCoordinateRegion
    let lineCoordinates: [CLLocationCoordinate2D]
    let mapView = MKMapView()
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        mapView.delegate = context.coordinator
    }
    
    func makeUIView(context: Context) -> MKMapView {

        mapView.delegate = context.coordinator
        mapView.region = region
        
        let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
        mapView.addOverlay(polyline)
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

// MARK: Coordinator for using UIKit inside SwiftUI
class Coordinator: NSObject, MKMapViewDelegate{
    var parent: PolylineView
    
    init(_ parent: PolylineView){
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline{
            let lineRenderer = MKPolylineRenderer(polyline: routePolyline)
            lineRenderer.strokeColor = UIColor.systemBlue
            lineRenderer.lineWidth = 4
            return lineRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

