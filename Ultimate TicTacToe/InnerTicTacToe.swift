//
//  InnerTicTacToe.swift
//  Ultimate TicTacToe
//
//  Created by Shyam Kumar on 9/23/21.
//

import UIKit

class InnerTicTacToe: UIView {
    
    var paths: [CAShapeLayer] = []
    var completion: () -> Void = { return }
    var winner: Player = .none
    var newValid: (Int) -> Void = { _ in return }
    
    lazy var outerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 4
        
        for row in 1..<4 {
            stack.addArrangedSubview(innerStackFactory(row: row))
        }
        
        return stack
    }()
    
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
        stack.spacing = 4
        for i in 0..<3 {
            let view = BlankView()
            view.tapClosure = tapClosure
            view.tag = ( row * 10 + i)
            stack.addArrangedSubview(view)
        }
        return stack
    }
    
    func drawLine(axis: Axis, prop: Double, frame: CGRect) {
        switch axis {
        case .horizontal:
            let layer = CAShapeLayer(layer: layer)
            let path = UIBezierPath()
            let propY = frame.maxY * CGFloat(prop)
            path.move(to: CGPoint(x: 0, y: propY))
            path.addLine(to: CGPoint(x: frame.maxX, y: propY))
            layer.path = path.cgPath
            layer.strokeColor = UIColor.black.cgColor
            layer.lineWidth = 1
            self.layer.addSublayer(layer)
            paths.append(layer)
        case .vertical:
            let layer = CAShapeLayer(layer: layer)
            let path = UIBezierPath()
            let propX = frame.maxX * CGFloat(prop)
            path.move(to: CGPoint(x: propX, y: 0))
            path.addLine(to: CGPoint(x: propX, y: frame.maxY))
            layer.path = path.cgPath
            layer.strokeColor = UIColor.black.cgColor
            layer.lineWidth = 1
            self.layer.addSublayer(layer)
            paths.append(layer)
        }
    }
    
    func tapClosure(tag: Int) {
        newValid(tag)
        let playerArr = buildArrFromStack()
        var results: [Player] = []
        results.append(checkHorizontals(arr: playerArr))
        results.append(checkVerticals(arr: playerArr))
        results.append(checkDiagonals(arr: playerArr))
        
        let filtered = results.filter({$0 != .none})
        
        if filtered.count > 0 {
            switch filtered[0] {
            case .x:
                replaceSubviewsWith(view: xView)
                winner = .x
                completion()
            case .o:
                replaceSubviewsWith(view: oView)
                winner = .o
                completion()
            default:
                print("none")
            }
        }
    }
    
    func buildArrFromStack() -> [[Player]] {
        var retArr: [[Player]] = [[], [], []]
        
        for i in 0..<outerStack.arrangedSubviews.count {
            if let innerStack = outerStack.arrangedSubviews[i] as? UIStackView {
                for subview in innerStack.arrangedSubviews {
                    if let view = subview as? BlankView {
                        retArr[i].append(view.player)
                    }
                }
            }
        }
        return retArr
    }
    
    func checkForWin(arr: [[Player]]) -> Player {
        return checkHorizontals(arr: arr)
    }
    
    func checkForWinInSubArr(innerArr: [Player]) -> Player {
        if let checkAgainst = innerArr.first,
           checkAgainst != .none {
            for player in innerArr {
                if player != checkAgainst {
                    return .none
                }
            }
            return checkAgainst
        }
        return .none
    }
    
    func checkHorizontals(arr: [[Player]]) -> Player {
        for innerArr in arr {
            let winner = checkForWinInSubArr(innerArr: innerArr)
            if winner != .none {
                return winner
            }
        }
        return .none
    }
    
    func checkVerticals(arr: [[Player]]) -> Player {
        for index in 0..<3 {
            let vertical = arr.map({ $0[index] })
            let winner = checkForWinInSubArr(innerArr: vertical)
            if winner != .none {
                return winner
            }
        }
        return .none
    }
    
    func checkDiagonals(arr: [[Player]]) -> Player {
        var firstDiagonal: [Player] = []
        
        for index in 0..<3 {
            firstDiagonal.append(arr[index][index])
        }
        
        let winner = checkForWinInSubArr(innerArr: firstDiagonal)
        if winner != .none {
            return winner
        }
        
        let secondDiagonal: [Player] = [arr[0][2], arr[1][1], arr[2][0]]
        let secondWinner = checkForWinInSubArr(innerArr: secondDiagonal)
        if secondWinner != .none {
            return secondWinner
        }
        
        return .none
    }
    
    func replaceSubviewsWith(view: UIView) {
        UIView.animate(
            withDuration: 0.3,
            animations: { [self] in
                for view in outerStack.arrangedSubviews {
                    if let view = view as? UIStackView {
                        for subview in view.arrangedSubviews {
                            subview.removeFromSuperview()
                            view.removeArrangedSubview(subview)
                        }
                        
                        outerStack.removeArrangedSubview(view)
                    }
                }
                outerStack.removeFromSuperview()
                
                for layer in paths {
                    layer.fadeOut()
                    layer.removeFromSuperlayer()
                }
            },
            completion: { [self] _ in
                addSubview(view)
                view.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
                view.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
                view.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
                view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
            }
        )
    }
    
    func setAsCurrentBoard() {
//        for layer in layer.sublayers! {
//            if let layer = layer as? CAShapeLayer {
//                layer.removeFromSuperlayer()
//                layer.strokeColor = UIColor.green.cgColor
//                layer.lineWidth = 1.5
//                self.layer.addSublayer(layer)
//                setNeedsDisplay()
//            }
//        }
        backgroundColor = Colors.purple.withAlphaComponent(0.3)
    }
    
    func removeAsCurrentBoard() {
//        for layer in layer.sublayers! {
//            if let layer = layer as? CAShapeLayer {
//                layer.removeFromSuperlayer()
//                layer.strokeColor = UIColor.black.cgColor
//                layer.lineWidth = 1
//                self.layer.addSublayer(layer)
//                setNeedsDisplay()
//            }
//        }
        backgroundColor = .clear
    }

}

extension CALayer : CAAnimationDelegate  {
    func fadeOut() {
        let fadeOutAnimation = CABasicAnimation()
        fadeOutAnimation.keyPath = "opacity"
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0
        fadeOutAnimation.duration = 0.000000001
        fadeOutAnimation.delegate = self
        self.add(fadeOutAnimation,
                     forKey: "fade")
    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.removeFromSuperlayer()
    }
}
