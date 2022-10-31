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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoVC = segue.destination as? InfoViewController else { return }
        guard let index = collectionView.indexPathsForSelectedItems?.first else { return }
        
        infoVC.character = characters[index.row]
    }
    
    func fetchCaracters() {
        NetworkManager.shared.fetch(dataType: [HPCharacter].self, url: List.url.rawValue) { result in
            switch result {
            case .success(let characters):
                self.characters = characters
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
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
