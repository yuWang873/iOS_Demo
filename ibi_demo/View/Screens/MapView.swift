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

    @State private var region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 43.64852093920521, longitude: -79.38019037246704), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    

    @State var annotations = [Annotation]()
    
    @State var presentAnnoView: Bool = false

    @State var polylineCoords: [CLLocationCoordinate2D] = []
    @State private var isPresented = false
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State var locations = [MKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    @State var showingPage3 = false

    var body: some View{
        
        ZStack{
            MapAnnotationView(region: region, centerCoordinate: $centerCoordinate,selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotation: locations, lineCoordinates: polylineCoords)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 16, height: 16)
            
            VStack{
                Spacer()
                HStack{

                    Button(action: {
                        for anno in annotations{
                            var newLocation = MKPointAnnotation()
                            newLocation.title = anno.name
                            newLocation.subtitle = anno.description
                            newLocation.coordinate = CLLocationCoordinate2D(latitude: anno.lat, longitude: anno.lon)
                            self.locations.append(newLocation)
                        }
                    }, label: {
                        Image(systemName: "mappin")
                    })
                    .padding()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50, alignment: .center
                    )
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.leading)
                    Spacer()
                
                    Spacer()
                    Button(action: {
                        drawLine()
                        
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .padding()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50, alignment: .center
                    )
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.trailing)
                

            }

        }
        .onAppear{
            loadLocations()
        }
        .alert(isPresented: $showingPlaceDetails, content: {
            Alert(title: Text("Show Details"),primaryButton: .default(Text("OK"),action:{
                    showingPage3 = true
                
                  
                
                //self.deleteCurrentView()
            }), secondaryButton: .default(Text("Cancel")))
            
        })
        .navigationBarTitle("")
        .sheet(isPresented: $showingPage3, content: { AnnotationView(anno: selectedPlace ?? MKPointAnnotation.example)})
    }
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
    
    func deleteCurrentView(){
        presentationMode.wrappedValue.dismiss()
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



