//
//  ContentView.swift
//  ObjectDetectionTests
//
//  Created by Ronaldo Gomes on 07/05/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var results: [String] = []
    
    internal var model = Model()
    
    var mlModel: MLNameModels
    
    var body: some View {
        VStack(spacing: 30) {
            Button("Chose image") {
                self.showingImagePicker = true
            }
            
            List(results, id: \.self) {
                Text("\($0)")
            }
        }
        .navigationBarTitle("\(mlModel.rawValue)")
        .fullScreenCover(isPresented: $showingImagePicker, onDismiss: loadModelResult) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    
    func loadModelResult() {
        guard let inputImage = inputImage else { return }
        //image = Image(uiImage: inputImage)
        DispatchQueue.main.async {
            results = model.results(for: mlModel, image: inputImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(mlModel: MLNameModels.mobileNetV2)
    }
}
