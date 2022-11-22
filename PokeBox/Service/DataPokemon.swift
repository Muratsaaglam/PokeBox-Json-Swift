//
//  DataPokemon.swift
//  PokeBox
//
//  Created by Murat Sağlam on 21.11.2022.
//

import Foundation

// Model
struct Pokemon: Decodable, Identifiable
{
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let imageUrl: String
    let type: String
}

