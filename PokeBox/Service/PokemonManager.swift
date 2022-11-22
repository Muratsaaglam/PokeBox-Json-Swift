//
//  PokemonManager.swift
//  PokeBox
//
//  Created by Murat Sağlam on 21.11.2022.
//

import Foundation

protocol pokemonManagerDelegede
{
    func showListPokemon(lists: [Pokemon])
}

struct PokemonManager
{
    var delegade: pokemonManagerDelegede?
    
    func verPokemon()
    {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString)
        {
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { data, respuesta, error in
                if error != nil
                {
                    print("Error API ",error?.localizedDescription)
                }
                
                if let dataSegue = data?.parseData(quitarString: "null,")
                {
                    if let listedPokemon = self.parsearJSON(dataPokemon: dataSegue)
                    {
                        print("List Pokemon: ", listedPokemon)
                        delegade?.showListPokemon(lists: listedPokemon)
                    }
                }
            }
            
            tarea.resume()
        }
    }
    
    func parsearJSON(dataPokemon: Data) -> [Pokemon]?
    {
        let decodificador = JSONDecoder()
        do
        {
            let datosDecodificados = try decodificador.decode([Pokemon].self, from: dataPokemon)
            
            return datosDecodificados
            
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
    func parseData(quitarString palabra: String) -> Data?
    {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: palabra, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
