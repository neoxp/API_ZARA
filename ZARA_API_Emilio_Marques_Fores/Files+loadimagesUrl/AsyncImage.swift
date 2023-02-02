//
//  AsyncImage.swift
//  Prueba_ZARA_Emilio_Marques_Fores
//
//  Created by Emilio_Marques_Fores on 2/2/23.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: imageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: imageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
    List{
            if loader.image != nil {
                image(loader.image!)
            } else {
                placeholder
            }
        }
    }
}
