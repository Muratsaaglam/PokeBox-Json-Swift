//
//  CellPokemonTableViewCell.swift
//  PokeBox
//
//  Created by Murat Sağlam on 21.11.2022.
//

import UIKit

class CellPokemonTableViewCell: UITableViewCell
{

    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeDefense: UILabel!
    @IBOutlet weak var pokeAttack: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        imagePokemon.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }
    
}
