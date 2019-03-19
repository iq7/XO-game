//
//  MarkView.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

public class MarkView: UIView, Copying {
    
    // MARK: - Properties
    
    public var lineColor: UIColor = .black
    public var lineWidth: CGFloat = 7
    public var textColor: UIColor = .red
    
    internal private(set) lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = lineColor.cgColor
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
    }()
    
    // MARK: - Init
    
    public init() {
        super.init(frame: CGRect(origin: .zero,
                                 size: CGSize(width: 90, height: 90)))
    }
    
    required init(_ prototype: MarkView) {
        super.init(frame: prototype.frame)
        self.lineColor = prototype.lineColor
        self.lineWidth = prototype.lineWidth
        self.textColor = prototype.textColor
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UIView
    
    public final override func layoutSubviews() {
        super.layoutSubviews()
        updateShapeLayer()
    }
    
    public override var frame: CGRect {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    public override var bounds: CGRect {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    // MARK: - Template methods
    
    internal func updateShapeLayer() {
        // meant for subclasses to override
    }
}
