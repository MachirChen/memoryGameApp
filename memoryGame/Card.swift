//
//  Card.swift
//  memoryGame
//
//  Created by Machir on 2021/8/10.
//

import UIKit

struct Card {
    var cardName:String?
    var cardImage:UIImage?
    var flipped:Bool? = false
}

var cards = [
    
    Card(cardName: "black3", cardImage: UIImage(named: "black3")),
    Card(cardName: "black4", cardImage: UIImage(named: "black4")),
    Card(cardName: "black5", cardImage: UIImage(named: "black5")),
    Card(cardName: "red3", cardImage: UIImage(named: "red3")),
    Card(cardName: "red4", cardImage: UIImage(named: "red4")),
    Card(cardName: "red5", cardImage: UIImage(named: "red5")),
    
    Card(cardName: "black3", cardImage: UIImage(named: "black3")),
    Card(cardName: "black4", cardImage: UIImage(named: "black4")),
    Card(cardName: "black5", cardImage: UIImage(named: "black5")),
    Card(cardName: "red3", cardImage: UIImage(named: "red3")),
    Card(cardName: "red4", cardImage: UIImage(named: "red4")),
    Card(cardName: "red5", cardImage: UIImage(named: "red5"))
    
]
