//
//  ImageListViewModel.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 07/01/24.
//

import Foundation


final class ImageDiaplayViewModel: ObservableObject {
    private var originalImageList: [ImgurImage] = []
    @Published var imageList:  [ImgurImage] = []
    @Published var isDetailViewActive = true

    // Fetchs Top Week Images form server and has completion handler.
    
    func getTopWeekImages(completion: @escaping (Bool) -> Void) {
        
        let apiClient = ApiClient()
        
        apiClient.getTopImagesFromImgur {[self] images in
            
            if let images = images {
                
                self.imageList = images
                self.originalImageList = images
                cleanImageArray()
                completion(true)
            
            } else {
                completion(false)
            
            }
        }
    }
    // Removes elements without imageurl
    private func cleanImageArray(){
        originalImageList = originalImageList.filter{$0.imageURL?.absoluteString != nil}
        imageList = originalImageList
    }
    
    // Filters the search retults
    func searchImage(searchString: String)  {
        if !searchString.isEmpty{
            imageList = originalImageList.filter {$0.title.lowercased().contains(searchString.lowercased())}
        } else{
            imageList = originalImageList
        }
        
    }    
}
