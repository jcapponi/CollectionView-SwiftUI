//
//  ContentView.swift
//  CollectionView-SwiftUI-MVVM
//
//  Created by Juan Capponi on 10/4/20.
//

import SwiftUI
import Combine


struct ContentView: View {
    @ObservedObject private var viewModel = PictureListViewModel()
    var body: some View {
        NavigationView {
        ScrollView(.vertical, showsIndicators: false) {
            if let counts = viewModel.viewModelPicturesArr?.count {
            ForEach(0..<counts) {
                row in
                HStack {
                    ForEach(viewModel.viewModelPicturesArr![row]) { im in
                    let img1 = im.large
                        URLImageView(urlString: img1).cornerRadius(8).frame(width: 150.0, height: 170.0)
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
          }
        }.onAppear(){
            self.viewModel.fetchPictsArray()
        }.navigationTitle("Scroll View")
    }
    }
}

class PictureListViewModel : ObservableObject {
    private let viewModelService = ViewModelDataSource()
    @Published var viewModelPictures = [ViewModelPictures]()

    var cancellable : AnyCancellable?
    var viewModelPicturesArr: [[ViewModelPictures]]? = nil
    
    func fetchPictsArray() {
        cancellable = viewModelService.fetchPictures().sink(receiveCompletion: {
            _ in
        },
        receiveValue:  { pictsContainer in
            self.viewModelPictures = pictsContainer.photos.map { ViewModelPictures(photographerName: $0.photographer, urlSmall: $0.src.small, medium: $0.src.large, large: $0.src.large2x)
            }
            self.viewModelPicturesArr = self.viewModelPictures.collection(into: 2)
        })
    }
}



