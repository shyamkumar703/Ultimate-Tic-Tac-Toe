//
//  ViewController.swift
//  Ultimate TicTacToe
//
//  Created by Shyam Kumar on 9/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - UI ELEMENTS
    var boldAttributes: [NSAttributedString.Key: Any] = [
        .font: Fonts.bold,
        .foregroundColor: UIColor.black
    ]
    
    var regularAttributes: [NSAttributedString.Key: Any] = [
        .font: Fonts.regular,
        .foregroundColor: UIColor.black
    ]
    
    lazy var gameTitle: UILabel = {
        let label = UILabel()
        label.attributedText = ViewController.generateAttributedString(
            str1: "Ultimate ",
            attr1: boldAttributes,
            str2: "Tic-Tac-Toe",
            attr2: regularAttributes
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var outerTicTacToe: OuterTicTacToe = {
        let view = OuterTicTacToe()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.addSubview(gameTitle)
        view.addSubview(outerTicTacToe)
    }
    
    func setupConstraints() {
        gameTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        gameTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        gameTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        gameTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        outerTicTacToe.heightAnchor.constraint(equalTo: outerTicTacToe.widthAnchor).isActive = true
        outerTicTacToe.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        outerTicTacToe.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        outerTicTacToe.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }


}

extension ViewController {
    static func generateAttributedString(
        str1: String,
        attr1: [NSAttributedString.Key: Any],
        str2: String,
        attr2: [NSAttributedString.Key: Any]
    ) -> NSMutableAttributedString {
        let mutableStr = NSMutableAttributedString(string: str1, attributes: attr1)
        let secondStr = NSMutableAttributedString(string: str2, attributes: attr2)
        mutableStr.append(secondStr)
        return mutableStr
    }
}

