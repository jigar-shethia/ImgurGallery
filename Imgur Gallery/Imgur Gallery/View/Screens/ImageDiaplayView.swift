//
//  ImageDiaplayView.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 06/01/24.
//

import SwiftUI

struct ImageDiaplayView: View {
    
    @StateObject var viewModel = ImageDiaplayViewModel()
    @State private var searchText = ""
    @EnvironmentObject var imageFlow: ImageFlow
    @State private var viewDidLoad = false
    @State private var isList = true
    @State private var isLoading = true
    
    
    var body: some View {
        
        NavigationStack(path: $imageFlow.path)  {
            if isLoading
            {
                ProgressView()
                Text("Loading…")
                    .padding(.top, 20)
            } else {
                ZStack{
                    ScrollView {
                        Toggle("Switch Layout", isOn: $isList)
                            .padding()
                            .font(.headline)
                            .fontWeight(.heavy)
                        if isList
                        {
                            ListView(viewModel: viewModel, delegate: self)
                        }else{
                            GridView(viewModel: viewModel, delegate: self)
                        }
                        
                        
                    }
                    .navigationTitle("Gallery")
                    .navigationDestination(for: ImageNavigation.self) { destination in
                        ImageViewFactory.setViewForDestination(destination)
                    }
                    
                }
                .padding()
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search, runSearch)
        .onChange(of: searchText, runSearch)
        .onAppear(perform: {
            if viewDidLoad == false {
                viewDidLoad = true
                
                viewModel.getTopWeekImages {completed in
                    isLoading = false
                }
            }
        })
    }
    
    func runSearch() {
        Task {
            viewModel.searchImage(searchString:searchText)
        }
    }
}
extension ImageDiaplayView: ListViewDelegate {
    func didSelectListItem() {
        imageFlow.navigateToImageDetailView()
    }
}
extension ImageDiaplayView: GrindViewDelegate{
    func didSelectGridItem() {
        imageFlow.navigateToImageDetailView()
    }
}
#Preview {
    ImageDiaplayView(viewModel: ImageDiaplayViewModel())
}
