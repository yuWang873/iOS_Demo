//
//  ContentView.swift
//  ibi_demo
//
//  Created by WY on 2021/6/23.
//

import SwiftUI
import MapKit
import Combine


struct ContentView: View {
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Page 1")
                    .font(.system(size: 32))
                    .padding(.all, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                NavigationLink(
                    destination: MapView(),
                    label: {
                        Image(systemName: "map.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .accentColor(.blue)
                            .frame(width: 50, height: 50, alignment: .center)
                        
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
