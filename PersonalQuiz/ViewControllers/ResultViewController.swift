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
            var animalCounts = [Animal: Int]()
            
            for answer in answerArray {
                animalCounts[answer.animal, default: 0] += 1
            }

            let maxCount = animalCounts.values.max()
            let frequentAnswers = animalCounts.filter { $0.value == maxCount }

            if frequentAnswers.count == 1 {
                if let (animal, _) = frequentAnswers.first {
                    resultLabel.text! += String("Вы - \(animal.rawValue)!")
                    definitionLabel.text = animal.definition
                }
            } else {
                for (animal, _) in frequentAnswers {
                    resultLabel.text! += String("Вы - \(animal.rawValue)!\n")
                    definitionLabel.text! += String("\n\n\(animal.definition)")
                }
            }
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    deinit {
        print("\(type(of: self)) has been deallocated")
    }
    
}

    

    

