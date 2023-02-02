//
//  ContentView.swift
//  ZARA_API_Emilio_Marques_Fores
//
//  Created by Emilio_Marques_Fores on 2/2/23.
//

import Foundation
import SwiftUI
import UIKit
import Combine


struct apiZara: Hashable,Codable{
    
    let name: String
    let status : String
    let species: String
    let gender: String
    let origin: String
  
    
    
}

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}


class Viewmodel: ObservableObject{
    
    @Published var zara:[apiZara] = []
    
    
    func fetch(){
        guard let url = URL(string: "https://rickandmortyapi.com") else {
              return
        }
        
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _,
            error in
         
            guard let data = data, error == nil else{
                
                 return
                
            }
            // PASAR DATOS A JSON
            do{
                let zara = try JSONDecoder().decode([apiZara].self, from: data)
                DispatchQueue.main.async {
                    self?.zara = zara
                }
                
            } catch{
                print(error)
            }
        }
        task.resume()
    }

}


let ApiZara = [
    "https://rickandmortyapi.com/api/character/avatar/46.jpeg",
    "https://image.tmdb.org/t/p/original//vqzNJRH4YyquRiWxCCOH0aXggHI.jpg",
    "https://image.tmdb.org/t/p/original//6ApDtO7xaWAfPqfi2IARXIzj8QS.jpg",
    "https://image.tmdb.org/t/p/original//7GsM4mtM0worCtIVeiQt28HieeN.jpg"
].map { URL(string: $0)! }


class Service: ObservableObject {
    @Published var itemsApiZara: [apiZara]

    init() {
        self.itemsApiZara = [
            apiZara(name:"", status:"", species:"",gender:"", origin:"")
        ]
    }
}


struct ContentView: View {
    @StateObject var viewModel = Viewmodel()
    
    var body: some View {
        NavigationView{
            
            VStack{
                
                List(ApiZara, id: \.self) { url in
                    AsyncImage(
                        url: url,
                        placeholder: {
                            
                            Group {
                                Text(ApiZara.description).bold()
                            }
                            
                            
                            
                        },
                        image: { Image(uiImage: $0)
                            
                        }
                   
                    )
                    .frame(width: 400, height: 400)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("The Rick and Morty API")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

