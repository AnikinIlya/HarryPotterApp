//
//  HPCharacter.swift
//  HarryPotterApp
//
//  Created by Anikin Ilya on 19.10.2022.
//

import Foundation

enum House: String, Decodable {
    case gryffindor = "Gryffindor"
    case ravenclaw = "Ravenclaw"
    case hufflepuff = "Hufflepuff"
    case slytherin = "Slytherin"
    case none = ""
}

struct HPCharacter: Decodable {
    let name: String
    let alternate_names: [String]
    let species: String
    let gender: String
    let house: House
    let dateOfBirth: String
    let wizard: Bool
    let ancestry: String
    let wand: Wand
    let patronus: String
    let hogwartsStudent: Bool
    let hogwartsStaff: Bool
    let actor: String
    let alternate_actors: [String]
    let alive: Bool
    let image: String
}

struct Wand: Decodable {
    let wood: String?
    let core: String?
    let length: Float?
}
