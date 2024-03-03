//
//  ViewController.swift
//  PersonalQuiz
//
//  Created by Pavel Dolgopolov on 20.02.2024.
//

import UIKit

final class QuestionsViewController: UIViewController {
    
    // MARK: - IBOulets
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionProgressView: UIProgressView!
    
    @IBOutlet var rangedSlider: UISlider!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var rangedStackView: UIStackView!
    
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    
    @IBOutlet var rangedLabels: [UILabel]!
    // MARK: - Private methods
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answersChosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        let answerCount = Float(currentAnswers.count - 1)
        
        rangedSlider.maximumValue = answerCount
        rangedSlider.value = answerCount / 2
    }
    
    // MARK: - Overrides Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as? ResultViewController
        resultVC?.answers = answersChosen
    }
    
    // MARK: - IB Action
    @IBAction func singleButtonAnswerPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answersChosen.append(currentAnswer)
        nextQuestion()
    }
    
    @IBAction func multipleButtonAnswerPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
}
// MARK: - PrivateMetods

private extension QuestionsViewController {
    
    func updateUI() {
        [singleStackView, multipleStackView, rangedStackView].forEach { stackView in
            stackView?.isHidden = true
        }
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        let currentQuestion = questions[questionIndex]
        
        questionLabel.text = currentQuestion.title
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionProgressView.setProgress(totalProgress, animated: true )
        
        showAnswersType(for: currentQuestion.type)
    }
    
    /// Choice of answers category
    ///
    /// Displaying answers to a question according to a category
    /// - Parameter type: Specifies the category of responses
    func showAnswersType(for type: ResponseType) {
        switch type {
            case .single: showSingleStackView(with: currentAnswers)
            case .multiple: showMultipleStackView(with: currentAnswers)
            case .ranged: showRangedStackView(with: currentAnswers)
        }
    }
    
    func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden.toggle()
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden.toggle()
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
