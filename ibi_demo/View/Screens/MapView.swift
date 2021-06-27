//
//  mapView.swift
//  ibi_demo
//
//  Created by WY on 2021/6/24.
//

import SwiftUI
import MapKit
import Combine

struct MapView: View {

    // MARK: Properties
    @ObservedObject private var locationManager = LocationHandler()
    @State private var region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 43.64852093920521, longitude: -79.38019037246704), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
    @State private var cancellable: AnyCancellable?
    @State var annotations = [Annotation]()
    @State var presentAnnoView: Bool = false
    @State private var route: MKRoute?
    @State var polylineCoords: [CLLocationCoordinate2D] = []
    private let mapView = MKMapView()
    @State private var isPresented = false

    var body: some View{
        VStack{
            if locationManager.location != nil {
                
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil, annotationItems: annotations) { annotation in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: annotation.lat, longitude: annotation.lon)) {
                        Button(action: {
                            presentAnnoView = true
                        }, label: {
                            Image(systemName: "mappin")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40, alignment: .center)
                                .accentColor(Color(hex: annotation.color))
                                .foregroundColor(Color(hex: annotation.color))
                                .sheet(isPresented: $presentAnnoView, content: {
                                    AnnotationView(annotation: annotation)
                                })
                        })
                    }
                    
                }
                
            } else {
                Text("No user location avaliable")
            }
            
            HStack{
                Button(action: {
                    loadLocations()
                    
                }, label: {
                    Text("Show Annotation")
                })
                .padding(.all, 6)
                .cornerRadius(10)
                .frame(width: 180, height: 40, alignment: .center)
                    
                NavigationLink(
                    
                    destination: PolylineView(region: region, lineCoordinates: polylineCoords)
                        .navigationBarTitle("Polyline View"),
                    label: {
                        Text("Draw Polyline")
                            .padding(.all, 6)
                            .cornerRadius(10)
                            .frame(width: 180, height: 40, alignment: .center)
                    })
            }

        }
        .onAppear{
            setCurrentLocation()
            drawLine()
        }

        .navigationBarTitle("Map View")
    }
    
    // MARK: Helper Function
    
    func loadLocations(){
        guard let path = Bundle.main.path(forResource: "annotations", ofType: "json") else {fatalError("File not found")}
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {return}

        let decoder = JSONDecoder()

        let annotations = try? decoder.decode([Annotation].self, from: data)
        if let annotations = annotations{
            self.annotations = annotations
        }
        print(annotations)

    }
    
    func drawLine(){
        print("processing json")
        guard let path = Bundle.main.path(forResource: "paths", ofType: "json") else {fatalError("File not found")}
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {return}
        let jsonResult = try! JSONSerialization.jsonObject(with: data) as? [String: Any]
        if let coords = jsonResult?["polyline"] as? [NSArray]{
            for coordinate in coords {
                let lat = coordinate[0]
                let lon = coordinate[1]
                polylineCoords.append(CLLocationCoordinate2D(latitude: lat as! CLLocationDegrees, longitude: lon as! CLLocationDegrees))
                
            }
        }

    }
        
    private func setCurrentLocation(){
        cancellable = locationManager.$location.sink { location in
            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
            
        }
    }

}

struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Dismiss Modal") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}


