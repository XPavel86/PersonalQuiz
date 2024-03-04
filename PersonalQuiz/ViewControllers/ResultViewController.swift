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
        
        if let answers = answers {
            var animal: Animal?
            var duplicate = false
            
            for i in 0..<answers.count {
                for j in (i + 1)..<answers.count {
                    if answers[i].animal == answers[j].animal {
                        duplicate = true
                        animal = answers[i].animal
                        break
                    }
                }
            }
            
            if !duplicate {
                animal = answers.sorted(by: {
                    $0.animal.rawValue < $1.animal.rawValue }).first?.animal
            }
            resultLabel.text = "Вы - \(animal!.rawValue)!"
            definitionLabel.text = animal?.definition
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
 
Вариант 2
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
 */

