//
//  CellNewPokemonTableViewCell.swift
//  PokeBox
//
//  Created by Murat Sağlam on 22.11.2022.
//

import UIKit

class CellNewPokemonTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var imagePoke: UIImageView!
    @IBOutlet weak var pokeDefensive: UILabel!
    @IBOutlet weak var pokeAttack: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        imagePoke.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }
    
}


