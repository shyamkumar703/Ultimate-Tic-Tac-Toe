//
//  OuterTicTacToe.swift
//  Ultimate TicTacToe
//
//  Created by Shyam Kumar on 9/23/21.
//

import UIKit

class OuterTicTacToe: UIView {
    
    lazy var outerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 12
        
        for row in 1..<4 {
            stack.addArrangedSubview(innerStackFactory(row: row))
        }
        
        return stack
    }()
    
    override func draw(_ rect: CGRect) {
        drawLine(axis: .vertical, prop: (1/3), frame: rect)
        drawLine(axis: .vertical, prop: (2/3), frame: rect)
        drawLine(axis: .horizontal, prop: (1/3), frame: rect)
        drawLine(axis: .horizontal, prop: (2/3), frame: rect)
    }
    
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
        addSubview(outerStack)
    }
    
    func setupConstraints() {
        outerStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        outerStack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        outerStack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        outerStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func innerStackFactory(row: Int = 1) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 12
        for i in 0..<3 {
            let view = InnerTicTacToe()
            view.tag = row * 10 + i
            view.newValid = setNewValid(tag:)
            view.completion = squareWon
            stack.addArrangedSubview(view)
        }
        return stack
    }
    
    func setNewValid(tag: Int) {
        for innerStack in outerStack.arrangedSubviews {
            if let innerStack = innerStack as? UIStackView {
                for view in innerStack.arrangedSubviews {
                    if let view = view as? InnerTicTacToe {
                        if view.tag != tag {
                            view.isUserInteractionEnabled = false
                            view.removeAsCurrentBoard()
                        } else {
                            view.isUserInteractionEnabled = true
                            view.setAsCurrentBoard()
                        }
                    }
                }
            }
        }
        
    }
    
    func squareWon() {
        
    }
    
    func drawLine(axis: Axis, prop: Double, frame: CGRect) {
        switch axis {
        case .horizontal:
            let path = UIBezierPath()
            let propY = frame.maxY * CGFloat(prop)
            path.move(to: CGPoint(x: 0, y: propY))
            path.addLine(to: CGPoint(x: frame.maxX, y: propY))
            path.lineWidth = 2
            path.stroke()
        case .vertical:
            let path = UIBezierPath()
            let propX = frame.maxX * CGFloat(prop)
            path.move(to: CGPoint(x: propX, y: 0))
            path.addLine(to: CGPoint(x: propX, y: frame.maxY))
            path.lineWidth = 2
            path.stroke()
        }
    }

}

enum Axis {
    case horizontal
    case vertical
}
