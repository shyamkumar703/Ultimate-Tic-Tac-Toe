//
//  OView.swift
//  Ultimate TicTacToe
//
//  Created by Shyam Kumar on 9/23/21.
//

import UIKit

class OView: UIView {

    override func draw(_ rect: CGRect) {
        let haloPath = UIBezierPath(ovalIn: rect).cgPath
        let haloLayer = CAShapeLayer(layer: layer)
        haloLayer.path = haloPath
        haloLayer.fillColor = UIColor.clear.cgColor
        haloLayer.strokeColor = Colors.red.cgColor
        haloLayer.lineWidth = 1
        layer.addSublayer(haloLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
