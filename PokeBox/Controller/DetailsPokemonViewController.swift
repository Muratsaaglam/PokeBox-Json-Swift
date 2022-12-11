//
//  DetailsPokemonViewController.swift
//  PokeBox
//
//  Created by Murat Sağlam on 22.11.2022.
//

import UIKit

class DetailsPokemonViewController: UIViewController
{
    @IBOutlet weak var defensivePokemon: UILabel!
    @IBOutlet weak var attackPokemon: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var typePokemon: UILabel!
    @IBOutlet weak var descriptionPokemon: UITextView!
    
    //Variables
    var pokemonShow: Pokemon?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        imagePokemon.loadFrom(URLAddres: pokemonShow?.imageUrl ?? "")
        typePokemon.text = "Type : \(pokemonShow?.type ?? "")".uppercased()
        attackPokemon.text = "Attack : \(pokemonShow!.attack)"
        defensivePokemon.text = "Defensive : \(pokemonShow!.defense)"
        descriptionPokemon.text = pokemonShow?.description ?? ""
    }
    
}

extension UIImageView
{
    func loadFrom(URLAddres: String)
    {
        guard let url = URL(string: URLAddres) else { return }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url)
            {
                if let loadedImage = UIImage(data: imageData)
                {
                    self?.image = loadedImage
                }
            }
        }
    }
}
