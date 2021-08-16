//
//  ViewController.swift
//  memoryGame
//
//  Created by Machir on 2021/8/9.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var pairLabel: UILabel!
    @IBOutlet var cardBtns: [UIButton]!
    
    var time:Timer?
    var cards = [Card]()
    var pickedCard = [Int]()
    var pair = 0
    
    var seeTime = 3
    var gameTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameInit()
    }
    
    func gameInit() {
        
        countDownLabel.text = String(seeTime)
        pairLabel.text = String(pair)
        
        cards = [
            
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
        cards.shuffle()
        displayCards()
        
    }
    
    func displayCards() {
        for(i,_) in cards.enumerated() {
            cardBtns[i].setImage(cards[i].cardImage, for: .normal)
            cards[i].flipped = true
        }
        if time==nil {
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        }
    }
    
    @objc func countDown() {
        seeTime -= 1
        if seeTime == 0 {
            time?.invalidate()
            time = nil
            for (i,_) in cards.enumerated() {
                cardBtns[i].setImage(UIImage(named: "background"), for: .normal)
                UIView.transition(with: cardBtns[i], duration: 0.3, options: .showHideTransitionViews, animations: nil, completion: nil)
                cards[i].flipped = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                UIView.transition(with: self.timeView, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                self.countDownLabel.text = String(self.gameTime)
                self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.gameTimeCountDown), userInfo: nil, repeats: true)
            }
        }
        countDownLabel.text = String(seeTime)
    }
    
    @objc func gameTimeCountDown() {
        gameTime -= 1
        countDownLabel.text = String(gameTime)
        if gameTime == 0 {
            time?.invalidate()
            time = nil
            let timeOutAlertController = UIAlertController(title: "已超過時間", message: "再試一次", preferredStyle: .alert)
            let timeOutAlertAction = UIAlertAction(title: "重新開始", style: .default) { (_) in
                self.restart()
            }
            timeOutAlertController.addAction(timeOutAlertAction)
            present(timeOutAlertController, animated: true, completion: nil)
        }
    }
    
    func restart() {
        seeTime = 3
        gameTime = 60
        pair = 0
        pickedCard.removeAll()
        
        for i in cardBtns {
            i.isEnabled = true
        }
        gameInit()
    }
    
    @IBAction func flipCard(_ sender: UIButton) {
        
        func flip(index: Int) {
            if cards[index].flipped == false {
                cardBtns[index].setImage(cards[index].cardImage, for: .normal)
                UIView.transition(with: cardBtns[index], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                cards[index].flipped = true
            } else {
                cardBtns[index].setImage(UIImage(named: "background"), for: .normal)
                UIView.transition(with: cardBtns[index], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                cards[index].flipped = false
            }
        }
        
        if let cardNumber = cardBtns.firstIndex(of: sender) {
            print(pickedCard)
            
            if pickedCard.count == 0 {
                pickedCard.append(cardNumber)
                flip(index: cardNumber)
            } else {
                pickedCard.append(cardNumber)
                flip(index: cardNumber)
                if cards[pickedCard[0]].cardName == cards[pickedCard[1]].cardName {
                    print("相同")
                    
                    for i in self.pickedCard{
                        self.cardBtns[i].isEnabled = false
                        UIView.transition(with: self.cardBtns[i], duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
                    }
                    self.pickedCard.removeAll()
                    self.pair += 1
                    self.pairLabel.text = String(self.pair)
                    if self.pair == 6 {
                        self.time?.invalidate()
                        self.time = nil
                        let controller = UIAlertController(title: "挑戰成功", message: "再來一場", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.restart()
                        }
                        controller.addAction(action)
                        present(controller, animated: true, completion: nil)
                    }
                } else {
                    print("不同")
                    Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { (_) in
                        for (_,i) in self.pickedCard.enumerated() {
                            flip(index: i)
                        }
                        self.pickedCard.removeAll()
                    }
                }
            }
        }
    }
}

