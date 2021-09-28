//
//  BlankView.swift
//  Ultimate TicTacToe
//
//  Created by Shyam Kumar on 9/23/21.
//

import UIKit

class BlankView: UIView {
    
    var isValidMove: Bool = true
    var player: Player = .none
    var tapClosure: (Int) -> Void = { _ in return }
    
    lazy var xView: XView = {
        let view = XView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var oView: OView = {
        let view = OView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .clear
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapInView))
        addGestureRecognizer(tapGesture)
    }
    
    func setupConstraints() {
    }
    
    @objc func tapInView() {
        if isValidMove {
            switch GameState.turn {
            case .x:
                addXView()
            case .o:
                addOView()
            default:
                print("none")
            }
            GameState.changeTurn()
            tapClosure(tag)
        }
    }
    
    func addXView() {
        addSubview(xView)
        xView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        xView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        xView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        xView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        isValidMove = false
        player = .x
    }
    
    func addOView() {
        addSubview(oView)
        oView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        oView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        oView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        oView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        isValidMove = false
        player = .o
    }

}

enum Player {
    case x
    case o
    case none
}
