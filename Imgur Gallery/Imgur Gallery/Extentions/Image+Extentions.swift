//
//  Image+Extentions.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 06/01/24.
//
import SwiftUI


// Extention for AsyncImage 
extension Image {
    func imagemodifier() -> some View {
        self .resizable()
            .scaledToFit()
    }
    func iconModifier() -> some View {
        self.imagemodifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}
