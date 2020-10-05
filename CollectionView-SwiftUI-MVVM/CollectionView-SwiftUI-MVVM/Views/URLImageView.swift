//
//  URLImageView.swift
//  CollectionView-SwiftUI-MVVM
//
//  Created by Juan Capponi on 10/4/20.
//

import SwiftUI


struct URLImageView: View {
    
    @ObservedObject var urlImageModel: URLImageModel
    
    init(urlString: String?){
        urlImageModel = URLImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? URLImageView.defaultImage!)
            .resizable()
            .scaledToFit()
    }
    
    static var defaultImage = UIImage(named: "loading.jpg")
    
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: nil)
    }
}


