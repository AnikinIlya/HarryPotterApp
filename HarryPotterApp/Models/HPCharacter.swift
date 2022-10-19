//
//  HPCharacter.swift
//  HarryPotterApp
//
//  Created by Anikin Ilya on 19.10.2022.
//

import Foundation

enum House: Decodable {
    case gryffindor
    case ravenclaw
    case hufflepuff
    case slytherin
}

struct HPCharacter: Decodable {
    let name: String
    let alternate_names: [String]
    let species: String
    let gender: String
    let house: String
    let dateOfBirth: String
    let wizard: Bool
    let ancestry: String
    let eyeColour: String
    let hairColour: String
//    let wand: Wand
    let patronus: String
    let hogwartsStudent: Bool
    let hogwartsStaff: Bool
    let actor: String
    let alternate_actors: [String]
    let alive: Bool
    let image: String
}

//struct Wand: Decodable {
//    let wood: String?
//    let core: String?
//    let length: Int?
//}
