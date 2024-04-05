//
//  ViewController.swift
//  CatchTheShrimp
//
//  Created by 이자민 on 4/4/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    private var shrimpImageView: UIImageView!
    var score: Int = 0
    var countdownTimer: Timer?
    var imageTimer: Timer?
    var timeLeft: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        timerLabel.text = String(timeLeft)
        startGame()
    }
    
    func startGame() {
        startTimer()
        startImageTimer()
    }
    
    func startTimer() {
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeLeft -= 1
        timerLabel.text = "\(timeLeft)"
        
        if timeLeft == 0 {
            endGame()
        }
    }
    
    func endGame() {
        countdownTimer?.invalidate()
        imageTimer?.invalidate()
        showRestartAlert()
    }
    
    func showRestartAlert() {
        let alert = UIAlertController(title: "Do you want to restart or quit?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.score = 0
            self.scoreLabel.text = "Score: \(self.score)"
            self.timeLeft = 10
            self.timerLabel.text = "\(self.timeLeft)"
            self.startGame()
        }))
        alert.addAction(UIAlertAction(title: "Quit", style: .destructive, handler: { _ in
            // Quit the game
            self.quitGame()
        }))
        present(alert, animated: true, completion: nil)
    }

    func quitGame() {
        // Add any cleanup code here
        // For example, dismiss the view controller or perform other necessary actions
        dismiss(animated: true, completion: nil)
    }
    func startImageTimer() {
        imageTimer?.invalidate()
        imageTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(showRandomImage), userInfo: nil, repeats: true)
    }
    
    @objc func showRandomImage() {
        if shrimpImageView != nil {
            shrimpImageView.removeFromSuperview()
        }
        
        shrimpImageView = UIImageView(image: UIImage(named: "shrimp"))
        shrimpImageView.contentMode = .scaleAspectFit
        
        let x = CGFloat.random(in: 0...(view.frame.width - 100))
        
        let y = CGFloat.random(in: timerLabel.frame.maxY+100...scoreLabel.frame.minY-100)

        
        shrimpImageView.frame = CGRect(x: x, y: y, width: 100, height: 100)
        view.addSubview(shrimpImageView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(shrimpTapped))
        shrimpImageView.isUserInteractionEnabled = true
        shrimpImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func shrimpTapped() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
}

