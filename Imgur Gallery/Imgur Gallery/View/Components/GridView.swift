//
//  GrindView.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 09/01/24.
//

import SwiftUI
protocol GrindViewDelegate {
    func didSelectGridItem()
}

struct GridView: View {
    @StateObject var viewModel = ImageDiaplayViewModel()
    var delegate: GrindViewDelegate?
    
    var body: some View {
        
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
            ForEach(viewModel.imageList) { image in
              
                if let imageUrl = image.imageURL {
                    AsyncImage(url: imageUrl, transaction: Transaction(animation: .spring(response: 0.5,dampingFraction: 0.6, blendDuration: 0.25))) {
                        
                        phase in
                        
                        switch(phase){
                        case.success(let image):
                            image.imagemodifier()
                                .transition(.scale)
                        case .empty:
                            Image(systemName: "photo.circle.fill").iconModifier()
                        case .failure(let error):
                            AsyncImage(url: imageUrl, transaction: Transaction(animation: .spring(response: 0.5,dampingFraction: 0.6, blendDuration: 0.25))) { phase in
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
                    .cornerRadius(3)
                    .onTapGesture {
                        delegate?.didSelectGridItem()
                        ImageFlow.shared.selectedImage = image
                        
                    }
                    .frame(width: 100, height: 120)
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    GridView()
}
