//
//  Cards.swift
//  CardMate
//
//  Created by Jordan Vaglivelo on 12/6/20.
//

import Foundation

struct Card: Codable, Hashable {
    var mainText:[String]
    var subText:[String] = ["",""]
    var side:Int = 0
}

struct CardSet: Codable, Hashable {
    var cards:[Card]
    var title:String
}

struct CardSets: Codable {
    var sets:[CardSet]
}

func encodeSets(set: CardSets) -> Data{
    do {
        // Create JSON Encoder
        let encoder = JSONEncoder()
        let data = try encoder.encode(set)
        defaults.setValue(data, forKey: "userSets")
        return data
    } catch {
        print("Unable to Encode")
        return Data()
    }
}

func decodeSet(data: Data) -> CardSets{
    do {
        // Create JSON Decoder
        let decoder = JSONDecoder()
        let set = try decoder.decode(CardSets.self, from: data)
        return set
    } catch {
        print("Unable to Decode")
    }
    return CardSets(sets: [CardSet]())
}
