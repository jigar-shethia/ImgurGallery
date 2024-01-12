//
//  ImageFlow.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 10/01/24.
//

import Foundation
import SwiftUI

/* This is custom nagivation for ease to navigate and also extra view can be added in future*/

class ImageFlow: ObservableObject {
    static let shared = ImageFlow()
    
    @Published var path = NavigationPath()
    @Published var selectedImage = ImgurImage(json: ["":""])

    func clear() {
        path = .init()
    }
    
    func navigateBackToRoot() {
        path.removeLast(path.count)
    }
    
    func backToPrevious() {
        path.removeLast()
    }
    
    func navigateToImageDetailView() {
        path.append(ImageNavigation.imageDetails)
    }
    

    func done() {
        path = .init()
    }
}

