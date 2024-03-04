//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Pavel Dolgopolov on 20.02.2024.
//

import UIKit

final class ResultViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    
    var answers: [Answer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        if let answerArray = answers {
            var animalCounts: [Animal: Int] = [:]
            
            for answer in answerArray {
                animalCounts[answer.animal, default: 0] += 1
            }
            
            let maxCount = animalCounts.values.max()
            let rateAnswers = animalCounts.filter { $0.value == maxCount }
            
            let animal = rateAnswers.count == 1
            ? rateAnswers.first!.key
            : rateAnswers.sorted(by: {
                $0.key.rawValue < $1.key.rawValue
            }).first!.key
            
            resultLabel.text = "Вы - \(animal.rawValue)!"
            definitionLabel.text = animal.definition
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    deinit {
        print("\(type(of: self)) has been deallocated")
    }
}




/*
 Код ниже, наверное более правильный, с точки зрения надежности. Но если учесть, что массив [Answer] не может быть пустым, то и более короткий вариант не должен вызвать ошибок.
 
 if frequentAnswers.count == 1 {
 if let (animal, _) = frequentAnswers.first {
 resultLabel.text = "Вы - \(animal.rawValue)!"
 definitionLabel.text = animal.definition
 }
 } else {
 // Сортировка и вывод первого элемента
 if let (animal, _) = frequentAnswers.sorted(by: {
 $0.key.rawValue < $1.key.rawValue }).first {
 resultLabel.text = "Вы - \(animal.rawValue)!"
 definitionLabel.text = animal.definition
 }
 }
 */
