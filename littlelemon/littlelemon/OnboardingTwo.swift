//
//  OnboardingTwo.swift
//  littlelemon
//
//  Created by chibundo Ilonze on 16/08/2023.
//

import SwiftUI
import PhotosUI



struct OnboardingTwo: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack (alignment: .trailing){
            if let inputImage = inputImage {
                Image(uiImage: inputImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:200, height: 100)
            } else{
                Image(systemName: "pencil")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:200, height: 100)
            
            }
                
                Image(systemName:("plus.circle.fill")).renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: 20)
                    .foregroundColor(Color("completeGreen"))
                    .frame(width:50, height:10)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showingImagePicker = true
                    }
            
                    .sheet(isPresented: $showingImagePicker){
                        EditorImagePicker(image: $inputImage)
                    }
            }
        }
    
}
    
struct EditorImagePicker: UIViewControllerRepresentable{
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate{
        var parent: EditorImagePicker
        
        init(_ parent: EditorImagePicker){
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self){image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
        
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        //configures ios to just be able to select images
        var config = PHPickerConfiguration()
        config.filter = .images
        
        //the view of picker
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        //leave empty for now
    }
}

struct OnboardingTwo_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTwo()
    }
}
