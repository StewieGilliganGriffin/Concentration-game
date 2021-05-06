//
//  ViewController.swift
//  Concentration
//
//  Created by Гаджи Агаханов on 28.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // Для избежания замкнутого круга используется lazy. Переменная не будет инициализирована, пока кто-то не попытается ее использовать
    private lazy var game = ConcentrationGame(numberOfPairOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    
    private(set) var touches = 0 {
        didSet {
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    private var emojiCollection = ["🐶","🐰","🐢","🐱","🦄","🐸","🐵","🐥","🐌","🐞","🦁","🐯"]
    
    private var emojiDictionary = [Card:String]()
    
    // Присваиваем идентификаторы смайлам
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            //Наполняем словать смайлами под случайными индексами и удаляем из массива добавленный смайл, чтобы не дублироваться
            emojiDictionary[card] = emojiCollection.remove(at: emojiCollection.count.arc4randomExtension)
        }
        return emojiDictionary[card] ?? "?"
    }

    private func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.4677700996, blue: 0.9209138751, alpha: 1)
            }
        }
    }
    
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel!
    
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
       
    }
    
    @IBAction func newGame() {
        game.resetGame()
        updateViewFromModel()
        touches = 0
    }
}

extension Int {
    var arc4randomExtension: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        
        for i in indices.dropLast() {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: diff.arc4randomExtension)
            swapAt(i, j)
        }
    }
}
