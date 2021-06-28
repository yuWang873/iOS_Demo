//
//  ContentView.swift
//  ibi_demo
//
//  Created by WY on 2021/6/23.
//

import SwiftUI
import MapKit
import Combine
import NavigationStack

struct ContentView: View {
    @State var showingMapView = false
    
    var body: some View {
        NavigationStackView{
            VStack{
                Text("Page 1")
                    .padding(.top, 10)
                    .font(.system(size: 32))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .offset(y:-60)
                
                PushView(
                    destination: MapView(), isActive:$showingMapView,
                    label: {
                        Button(action: {
                            
                            showingMapView = true
                        }, label: {
                            Image(systemName: "map.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .accentColor(.blue)
                                .frame(width: 50, height: 50, alignment: .center)
                        })
                        
                        
                        
                    })
                Text("Go to Map")
                
                }

        }
        .navigationBarTitle("")
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
