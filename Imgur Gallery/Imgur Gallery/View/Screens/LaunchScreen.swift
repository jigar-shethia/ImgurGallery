//
//  LaunchScreen.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 11/01/24.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var showMainContent = false

       var body: some View {
           VStack {
              
              Image("LaunchScreenImage").resizable()
                   .scaledToFit()
                   .animation(.default, value: 1)
           }
           .onAppear {
              
               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                   withAnimation {
                       showMainContent = true
                   }
               }
           }
           .fullScreenCover(isPresented: $showMainContent) {
               
               let viewModel = ImageDiaplayViewModel()
               ImageDiaplayView(viewModel: viewModel) .environmentObject(ImageFlow.shared)
           }
       }
}

#Preview {
    LaunchScreen()
}
