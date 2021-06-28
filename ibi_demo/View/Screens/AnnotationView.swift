//
//  AnnotationView.swift
//  ibi_demo
//
//  Created by WY on 2021/6/25.
//

import SwiftUI
import MapKit
import NavigationStack

struct AnnotationView: View {
    @State var anno: MKPointAnnotation

    @State private var showingAlert = false
    @State private var activateLink = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navStack: NavigationStack
    var body: some View {
        VStack{
            Text((anno.title ?? "No Title")!)
                    .bold()
                    .foregroundColor(.black)
                    .font(.system(size: 24))
                    .padding(.all, 10)
            Text((anno.subtitle ?? "No Description")!)
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
                    .padding(.all, 10)
                
                Button(action: {
                    showingAlert = true
                }, label: {
                    Image(systemName: "arrow.left.square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50, alignment: .center)
                    
                })
                .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("Go Back?"), primaryButton: .default(Text("Yes"), action: {
                        self.navStack.pop()
                        //self.presentationMode.wrappedValue.dismiss()
                        
                    }), secondaryButton: .cancel())
                    
                })
                
            }
        

    }
    
    func deleteCurrentView(){
        presentationMode.wrappedValue.dismiss()
    }
        
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        let annotation = MKPointAnnotation.example
        AnnotationView(anno: annotation)
    }
}
