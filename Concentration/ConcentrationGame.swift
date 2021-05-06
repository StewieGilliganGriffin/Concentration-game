//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Гаджи Агаханов on 28.04.2021.
//

import Foundation

class ConcentrationGame {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func resetGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            // Проверяем, что не нажата одна и та же карточка
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                // Проверяем на совпадение карточек
                if cards[matchingIndex] == cards[index] {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // Заполнение массива карточками
    init(numberOfPairOfCards: Int) {
        
        // Аварийное завершение программы, если число парных карт менше 0
        assert(numberOfPairOfCards > 0, "ConcentrationGame.init(\(numberOfPairOfCards): must have at least ane pair cards")
        
        for _ in 1...numberOfPairOfCards {
            
            //Создание новой карточки путем создания экземпляра структуры
            let card = Card()
            cards += [card,card]

        }
        cards.shuffle()
    }
}
