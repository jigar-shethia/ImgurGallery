//
//  DetailedView.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 09/01/24.
//

import SwiftUI


struct DetailedView: View {
    @EnvironmentObject var imageFlow: ImageFlow
    @State private var scale: CGFloat = 1.0
    var body: some View {
        
        ScrollView{
            VStack{
                ZStack {
                    AsyncImage(url: imageFlow.selectedImage?.imageURL, transaction: Transaction(animation: .spring(response: 0.5,dampingFraction: 0.6, blendDuration: 0.25))) {
                        
                        phase in
                        
                        switch(phase){
                        case.success(let image):
                            image.imagemodifier()
                        case .empty:
                            Image(systemName: "photo.circle.fill").iconModifier()
                        case .failure(let error):
                            AsyncImage(url: imageFlow.selectedImage?.imageURL) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } else{
                                    Image(systemName: "person.crop.circle.badge.exclamationmark")
                                }
                            }
                            Image(systemName: "person.crop.circle.badge.exclamationmark").iconModifier()
                        @unknown default:
                            ProgressView()
                        }
                    }
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .padding()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                self.scale = value.magnitude
                            }
                    )  
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                                
                            Text(imageFlow.selectedImage?.getDateString() ?? "")
                                .font(.caption)
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(3.0)
                                .padding(.bottom, 5)
                                .padding(.trailing, 5)
                        }
                    }
                    .padding()
                }
                Text(imageFlow.selectedImage?.title ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
        }.navigationTitle("Selected Image")
        
    }
}
