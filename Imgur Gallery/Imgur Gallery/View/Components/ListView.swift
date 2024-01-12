//
//  ListView.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 09/01/24.
//

import SwiftUI
protocol ListViewDelegate {
    func didSelectListItem()
}

struct ListView: View {
    @StateObject var viewModel:ImageDiaplayViewModel
    var delegate: ListViewDelegate?
    
    var body: some View {
        LazyVStack {
            ForEach(viewModel.imageList) { image in
                if let imageUrl = image.imageURL {
                    VStack {
                        ZStack{
                            AsyncImage(url: imageUrl, transaction: Transaction(animation: .spring(response: 0.5,dampingFraction: 0.6, blendDuration: 0.25))) {
                                
                                phase in
                                
                                switch(phase){
                                case.success(let image):
                                    image.imagemodifier()
                                        .transition(.scale)
                                case .empty:
                                    Image(systemName: "photo.circle.fill").iconModifier()
                                case .failure(let error):
                                    AsyncImage(url: imageUrl) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } else{
                                            Image(systemName: "person.crop.circle.badge.exclamationmark")
                                        }
                                    }
                                    
                                    let _ = print(error)
                                    Text("error 121: \(error.localizedDescription) \(imageUrl)").selectionDisabled(false)
                                    Image(systemName: "person.crop.circle.badge.exclamationmark").iconModifier()
                                @unknown default:
                                    ProgressView()
                                }
                                
                                
                            }
                            .cornerRadius(10)
                            .onTapGesture {
                                delegate?.didSelectListItem()
                                ImageFlow.shared.selectedImage = image
                                
                            }
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                        
                                    Text(image.getDateString())
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .background(Color.black.opacity(0.5))
                                        .cornerRadius(3.0)
                                }
                            }
                            .padding()
                            
                            
                        }
                        
                        Text(image.title)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top,5)
                        
                    }.padding(.bottom, 20)
                }
            }
        }
    }
}


