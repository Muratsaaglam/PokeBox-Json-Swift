//
//  PokemonManager.swift
//  PokeBox
//
//  Created by Murat Sağlam on 21.11.2022.
//

import Foundation

protocol pokemonManagerDelegate
{
    func showListPokemon(lists: [Pokemon])
}

struct PokemonManager
{
    var delegate: pokemonManagerDelegate?
    
    func verPokemon()
    {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString)
        {
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { data, response, error in
                if error != nil
                {
                    print("Error API ",error?.localizedDescription)
                }
                
                if let dataSegue = data?.parseData(quitarString: "null,")
                {
                    if let listedPokemon = self.parsearJSON(dataPokemon: dataSegue)
                    {
                        print("List Pokemon: ", listedPokemon)
                        delegate?.showListPokemon(lists: listedPokemon)
                    }
                }
            }
            
            tarea.resume()
        }
    }
    
    func parsearJSON(dataPokemon: Data) -> [Pokemon]?
    {
        let decoder = JSONDecoder()
        do
        {
            let dataDecoders = try decoder.decode([Pokemon].self, from: dataPokemon)
            
            return dataDecoders
            
        }
        catch
        {
            print("Error", error.localizedDescription)
            return nil
        }
    }
}

extension Data
{
    func parseData(quitarString words: String) -> Data?
    {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: words, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
