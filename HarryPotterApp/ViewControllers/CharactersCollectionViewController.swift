//
//  CharactersCollectionViewController.swift
//  HarryPotterApp
//
//  Created by Anikin Ilya on 19.10.2022.
//

import UIKit

class CharactersCollectionViewController: UICollectionViewController {
    
    private var characters: [HPCharacter] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCaracters()
    }
    
    func fetchCaracters() {
        NetworkManager.shared.fetch(dataType: [HPCharacter].self, url: List.url.rawValue) { hpCharacter in
            self.characters = hpCharacter
            self.collectionView.reloadData()
        }
    }
}

extension CharactersCollectionViewController {
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterViewCell
        else { return UICollectionViewCell() }
        let character = characters[indexPath.row]
        
        cell.configure(character: character)
        return cell
    }
}
