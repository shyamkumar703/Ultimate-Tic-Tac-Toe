//
//  XView.swift
//  Ultimate TicTacToe
//
//  Created by Shyam Kumar on 9/23/21.
//

import UIKit

class XView: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        Colors.blue.set()
        path.stroke()
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: rect.maxX, y: 0))
        path2.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path2.stroke()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
