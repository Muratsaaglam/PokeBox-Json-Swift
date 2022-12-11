//
//  ListPokemonViewController.swift
//  PokeBox
//
//  Created by Murat Sağlam on 21.11.2022.
//

import UIKit

class ListPokemonViewController: UIViewController
{
    //IBOutlets
    @IBOutlet weak var searchBarPokemon: UISearchBar!
    @IBOutlet weak var tableViewPokemon: UITableView!
    
    //Variables
    var pokemonManager = PokemonManager()
    var pokemons: [Pokemon] = []
    var pokemonFilter: [Pokemon] = []
    var pokemonSelected: Pokemon?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "PokeBox"
        
        //Register TableViewCell
        tableViewPokemon.register(UINib(nibName: "CellNewPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //DataSource && Delegate
        pokemonManager.delegate = self
        searchBarPokemon.delegate = self
        tableViewPokemon.delegate = self
        tableViewPokemon.dataSource = self
        
        //Pokemon List
        pokemonManager.verPokemon()
        
    }
}

//TableView Protocol
extension ListPokemonViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pokemonFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableViewPokemon.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellNewPokemonTableViewCell
        
        cell.pokeName.text = pokemonFilter[indexPath.row].name.uppercased()
        cell.pokeAttack.text = "Attack: \(pokemonFilter[indexPath.row].attack)"
        cell.pokeDefensive.text = "Defensive: \(pokemonFilter[indexPath.row].defense)"
       
        //Image Check Url Cell
        if let urlString = pokemonFilter[indexPath.row].imageUrl as? String
        {
            if let imageURL = URL(string: urlString)
            {
                DispatchQueue.global().async
                {
                    guard let imageData = try? Data(contentsOf: imageURL) else { return }
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async
                    {
                        cell.imagePoke.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        pokemonSelected = pokemonFilter[indexPath.row]
        performSegue(withIdentifier: "verPokemon", sender: self)
        tableViewPokemon.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "verPokemon"
        {
            let verPokemon = segue.destination as! DetailsPokemonViewController
            verPokemon.pokemonShow = pokemonSelected
        }
    }
    
}

//SearchBar
extension ListPokemonViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        pokemonFilter = []
        if searchText == ""
        {
            pokemonFilter = pokemons
        }
        else
        {
            for poke in pokemons
            {
                if poke.name.lowercased().contains(searchText.lowercased())
                {
                    pokemonFilter.append(poke)
                }
            }
        }
        self.tableViewPokemon.reloadData()
    }
}

//Delegate Pokemon
extension ListPokemonViewController: pokemonManagerDelegate
{
    func showListPokemon(lists: [Pokemon])
    {
        pokemons = lists
        
        DispatchQueue.main.async
        {
            self.pokemonFilter = lists
            self.tableViewPokemon.reloadData()
        }
    }
}
