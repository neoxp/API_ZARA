//
//  EnvironmentValues+ImageCache.swift
//  Prueba_ZARA_Emilio_Marques_Fores
//
//  Created by Emilio_Marques_Fores on 2/2/23.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
