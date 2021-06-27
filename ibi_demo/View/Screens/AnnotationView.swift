//
//  AnnotationView.swift
//  ibi_demo
//
//  Created by WY on 2021/6/25.
//

import SwiftUI

struct AnnotationView: View {
    
    @State var annotation: Annotation
    @State private var showingAlert = false
    @State private var activateLink = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            VStack{
                Text(annotation.name)
                    .bold()
                    .foregroundColor(.black)
                    .font(.system(size: 24))
                    .padding(.all, 10)
                Text(annotation.description ?? "No Description")
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
                        
                        self.presentationMode.wrappedValue.dismiss()

                    }), secondaryButton: .cancel())
                })
                
            }

            

    }
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        let annotation = Annotation(lat: 43.64852093920521, lon: -79.38019037246704, name: "IBI Test Start Point 1 Type 1", description: "IBI Start Point Description 1", color: "#ff0")
        AnnotationView(annotation: annotation)
    }
}
