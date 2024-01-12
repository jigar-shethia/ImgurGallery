//
//  ImageViewFactory.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 10/01/24.
//

import Foundation
import SwiftUI

class ImageViewFactory {
    
    static func setViewForDestination(_ destination: ImageNavigation) -> AnyView {
        
        // Every time you want to add a new view in ImageDisplay module handle the case here
        switch destination {
        case .imageDetails:
            return AnyView(DetailedView())
        }
        
        
    }
}
