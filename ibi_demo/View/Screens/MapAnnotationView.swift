//
//  PolylineView.swift
//  ibi_demo
//
//  Created by WY on 2021/6/26.
//

import Foundation
import MapKit
import SwiftUI

struct MapAnnotationView: UIViewRepresentable{
    

    // MARK: Properties
    //var polylineCoords: [CLLocationCoordinate2D] = []
    @ObservedObject private var locationManager = LocationHandler()
    //@State private var cancellable: AnyCancellable?
    let region: MKCoordinateRegion
    let mapView = MKMapView()
        
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    var annotation: [MKPointAnnotation]
    var lineCoordinates: [CLLocationCoordinate2D]
    
    
    
//    func setCurrentLocation(){
//        cancellable = locationManager.$location.sink { location in
//            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
//            
//        }
//    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //mapView.delegate = context.coordinator
        if annotation.count != uiView.annotations.count{
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(annotation)
        }
        
        if uiView.overlays.count > 0{
            uiView.removeOverlay(uiView.overlays[0])

        }
        let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
        uiView.addOverlay(polyline)
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        //mapView.region = region
        return mapView
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    

    
}

// MARK: Coordinator for using UIKit inside SwiftUI
class Coordinator: NSObject, MKMapViewDelegate{
    var parent: MapAnnotationView
    @State var tapped = false
    init(_ parent: MapAnnotationView){
        self.parent = parent
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        parent.centerCoordinate = mapView.centerCoordinate
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Placemark"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let button = UIButton(type: .detailDisclosure)
            button.addTarget(self, action: #selector(self.addView), for: .touchUpInside)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    @objc func addView(){
        tapped = true
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
        guard let placemark = view.annotation as? MKPointAnnotation else {return}
        parent.selectedPlace = placemark
        parent.showingPlaceDetails = true
        
//        Group{
//        NavigationLink(
//            destination: AnnotationView(title: placemark.title, subTitle: placemark.subtitle),
//            isActive: $tapped,
//            label: {
//                EmptyView()
//            })
//            
//        }
    }
}

extension MKPointAnnotation{
    static var example: MKPointAnnotation{
        let annotation = MKPointAnnotation()
        annotation.title = "Toronto"
        annotation.subtitle = "Home"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

//struct MapAnnotationView_Previews: PreviewProvider{
//
//    static var previews: some View{
//        
//        let region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 43.64852093920521, longitude: -79.38019037246704), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
//        
//        MapAnnotationView(region: region, centerCoordinate: .constant(MKPointAnnotation.example.coordinate), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(false), annotation: [MKPointAnnotation.example])
//    }
//}
