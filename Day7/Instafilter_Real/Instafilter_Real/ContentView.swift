//
//  ContentView.swift
//  Instafilter_Real
//
//  Created by Lucas Lee on 10/1/20.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage? //used to save to library
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var noImageError = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var filterName = "Sepia Tone"
    let context = CIContext()
    
    func loadImage() { //converts UImage inputImage to Image image
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys //differnet filters have different parameters
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            processedImage = uiImage
            image = Image(uiImage: uiImage)
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    var body: some View {
        let intensity = Binding<Double>( //reapply processing when intensity us updated
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0 //set filter intesity to this placeholder
                self.applyProcessing()
            }
        )
        
        NavigationView {
            VStack {
                ZStack {
                    Rectangle().fill(Color.secondary)
                    if image != nil {
                        image?.resizable().scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage)
                }

                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.vertical)

                HStack {
                    Button("\(self.filterName)") {
                        self.showingFilterSheet = true
                    }
                    .actionSheet(isPresented: $showingFilterSheet) {
                        ActionSheet(title: Text("Select a filter"), buttons: [
                            .default(Text("Crystallize")) {
                                self.filterName = "Crystallize"
                                self.setFilter(CIFilter.crystallize()) },
                            .default(Text("Edges")) {
                                self.filterName = "Edges"
                                self.setFilter(CIFilter.edges()) },
                            .default(Text("Gaussian Blur")) {
                                self.filterName = "Gaussian Blur"
                                self.setFilter(CIFilter.gaussianBlur()) },
                            .default(Text("Pixellate")) {
                                self.filterName = "Pixellate"
                                self.setFilter(CIFilter.pixellate()) },
                            .default(Text("Sepia Tone")) {
                                self.filterName = "Sepia Tone"
                                self.setFilter(CIFilter.sepiaTone()) },
                            .default(Text("Unsharp Mask")) {
                                self.filterName = "Unsharp Mask"
                                self.setFilter(CIFilter.unsharpMask()) },
                            .default(Text("Vignette")) {
                                self.filterName = "Vingette"
                                self.setFilter(CIFilter.vignette()) },
                            .cancel()
                        ])
                    }

                    Spacer()

                    Button("Save") {
                        guard let _ = image else{
                            self.noImageError = true
                            return
                        }
                        guard let processedImage = self.processedImage else { return }

                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }

                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                    .alert(isPresented: $noImageError) {
                        Alert(title: Text("Error"), message: Text("No availible image to save"), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
