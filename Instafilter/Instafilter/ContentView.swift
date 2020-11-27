//
//  ContentView.swift
//  Instafilter
//
//  Created by Thomas Kellough on 11/26/20.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var showingNoImageError = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()

    @State private var hasIntensity = false
    @State private var filterIntensity = 0.5
    
    @State private var hasRadius = false
    @State private var filterRadius: Double = 100
    
    @State private var hasScale = false
    @State private var filterScale: Double = 5
    
    // Contexts are expensive to create, so it's a good idea to create it once and keep it alive
    let context = CIContext()
    
    var body: some View {
        // Setup bindings for intensity, radius, and scale
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        
        let scale = Binding<Double>(
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(image == nil ? Color.secondary : Color.clear)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                if hasIntensity {
                    HStack {
                        Text("Intensity")
                        Slider(value: intensity, in: 0...1)
                    }.padding(.vertical)
                }
                
                if hasRadius {
                    HStack {
                        Text("Radius")
                        Slider(value: radius, in: 0...200)
                    }.padding(.vertical)
                }
                
                if hasScale {
                    HStack {
                        Text("Scale")
                        Slider(value: scale, in: 0...10)
                    }.padding(.vertical)
                }
                
                HStack {
                    Button(currentFilter.name.replacingOccurrences(of: "CI", with: "")) {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            self.showingNoImageError = true
                            return
                        }
                        
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        
                        imageSaver.errorHandler = {
                            print("Ooops: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystalize")) { self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                    .default(Text("GaussianBlur")) { self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) }
                ])
            }
            .alert(isPresented: $showingNoImageError) {
                Alert(title: Text("Error"), message: Text("There is no image to save!"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        print("Input Keys:\n\(inputKeys)")
        
        if inputKeys.contains(kCIInputIntensityKey) {
            self.hasIntensity = true
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        } else {
            self.hasIntensity = false
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            self.hasRadius = true
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        } else {
            self.hasRadius = false
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            self.hasScale = true
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        } else {
            self.hasScale = false
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
