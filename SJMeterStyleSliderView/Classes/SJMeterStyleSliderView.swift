//
//  SJSliderView.swift
//  SJSliderView
//
//  Created by mac on 24/07/18.
//  Copyright © 2018 SumitJagdev. All rights reserved.
//

import UIKit

public protocol SJSliderViewDelegate {
    func didChangeSelectedIndex(index : Int)
}
@IBDesignable public final class SJSliderView: UIView {
    
    @IBInspectable public var sliderContainerBGColor : UIColor? = .clear {
        didSet {
            self.setupAppearance()
        }
    }
    @IBInspectable public var sliderBGColor : UIColor? = .white {
        didSet {
            self.drawSlider()
        }
    }
    
    @IBInspectable public var arrowColor : UIColor? = .black {
        didSet {
            self.setupAppearance()
        }
    }
    
    @IBInspectable public var lineColor : UIColor? = .blue {
        didSet {
            self.drawSlider()
        }
    }
    
    @IBInspectable public var lineThikness : CGFloat = 1 {
        didSet {
            self.drawSlider()
        }
    }
    
    @IBInspectable public var arrowSize : CGFloat = 20 {
        didSet {
            self.setupAppearance()
        }
    }
    
    @IBInspectable public var topSpaceSliderToArrow : CGFloat = 10 {
        didSet {
            self.setupAppearance()
        }
    }
    
    @IBInspectable public var shouldDrawArrow : Bool = true {
        didSet {
            self.setupAppearance()
        }
    }
    
    @IBInspectable public var shouldDrawLabel : Bool = true {
        didSet {
            self.drawSlider()
        }
    }
    
    @IBInspectable public var labelFontSize : CGFloat = 10 {
        didSet {
            self.drawSlider()
        }
    }
    
    @IBInspectable public var labelTextColor : UIColor? = .black {
        didSet {
            self.drawSlider()
        }
    }
    
    @IBInspectable public var sliderItemWidth : CGFloat = 50 {
        didSet {
            self.drawSlider()
        }
    }
    @IBInspectable public var sliderItemHeight : CGFloat = 50 {
        didSet {
            self.drawSlider()
        }
    }
    @IBInspectable public var sliderLeftPadding : CGFloat = 25 {
        didSet {
            self.drawSlider()
        }
    }
    @IBInspectable public var sliderRightPadding : CGFloat = 25 {
        didSet {
            self.drawSlider()
        }
    }
    @IBInspectable public var sliderItemCount : Int = 25 {
        didSet {
            self.drawSlider()
        }
    }
    
    @IBInspectable public var labelPrefixText : String = "" {
        didSet {
            self.drawSlider()
        }
    }
    
    @IBInspectable public var labelPostfixText : String = "" {
        didSet {
            self.drawSlider()
        }
    }
    
    private var currentIndex : Int = 0
//    private(set) var itemCount: Int = 0
    
    public var selectedIndex: Int { return currentIndex }
    
    public var delegate : SJSliderViewDelegate!
    
    var indexArray : [CGPoint] = []
    
    
    var arrow : CAShapeLayer!
    var sliderScrollView : UIScrollView!
    var gestureView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    internal func commonInit() {
        self.reDrawArrow()
        self.drawSlider()
    }
    
    internal func setupAppearance() {
        self.backgroundColor = self.sliderContainerBGColor
        if self.arrow != nil {
            self.arrow.removeFromSuperlayer()
        }
        if self.shouldDrawArrow == true {
            self.reDrawArrow()
        }
        
        if self.sliderScrollView != nil {
            self.sliderScrollView.frame.origin.y = self.arrowSize + self.topSpaceSliderToArrow
        }
        self.clipsToBounds = true
        
    }
    
    internal func drawSlider() {
        self.indexArray = []
        if self.sliderScrollView != nil {
            self.sliderScrollView.removeFromSuperview()
        }
        //        let frameCenterBox = CGRect(x: 125, y: 0, width: self.sliderItemWidth, height: 100)
        let yAxis = self.arrowSize + self.topSpaceSliderToArrow
        
        let scrollFrame = CGRect(x: self.frame.size.width/2 - self.sliderItemWidth/2, y: yAxis, width: self.sliderItemWidth, height: self.frame.size.height - yAxis )
        
        sliderScrollView = UIScrollView(frame: scrollFrame)
        sliderScrollView.delegate = self
        self.addSubview(self.sliderScrollView)
        self.sliderScrollView.clipsToBounds = false
        self.sliderScrollView.isPagingEnabled = true
        
//        self.sliderScrollView.layer.borderColor = UIColor.white.cgColor
//        self.sliderScrollView.layer.borderWidth = 2
        self.sliderScrollView.showsHorizontalScrollIndicator = false
        self.sliderScrollView.showsVerticalScrollIndicator = false
        
        let yPos : CGFloat = 0
        var xPos : CGFloat = self.sliderItemWidth / 2
        let width : CGFloat = self.sliderItemWidth
        let height : CGFloat = self.sliderItemHeight
        let heightLabel : CGFloat = 20.0
        let numberOfBlock = self.sliderItemCount
        
        for i in 0..<numberOfBlock {
            let frameBox = CGRect(x: xPos, y: yPos, width: width, height: height)
            let box = UIView(frame: frameBox)
            self.sliderScrollView.addSubview(box)
            box.backgroundColor = self.sliderBGColor
            self.makeUIAsScale(view: box, part: 10)
            
            indexArray.append(box.frame.origin)
            
            
            if self.shouldDrawLabel == true {
                var xLabelPos = xPos - 5
                if i >= 9 {
                    xLabelPos = xPos - 10
                }
                let frameLabel = CGRect(x: xLabelPos , y: yPos + height, width: width, height: heightLabel)
                
                let label = UILabel(frame: frameLabel)
                self.sliderScrollView.addSubview(label)
                label.textColor = self.labelTextColor
                var textString = ""
                if self.labelPrefixText.isEmpty == false {
                    textString = self.labelPrefixText
                }
                textString = textString + " " + String(format: "%d", i)
                if self.labelPostfixText.isEmpty == false {
                    textString = textString + " " + self.labelPostfixText
                }
                label.text = textString
                label.font = UIFont.boldSystemFont(ofSize: self.labelFontSize)
                
                
                xPos += width // For next part
                
                if numberOfBlock == i + 1 {
                    var xLabelPos = xPos - 5
                    if i >= 9 {
                        xLabelPos = xPos - 10
                    }
                    let frameLabel = CGRect(x: xLabelPos , y: yPos + height, width: width, height: heightLabel)
                    
                    let label = UILabel(frame: frameLabel)
                    self.sliderScrollView.addSubview(label)
                    label.textColor = self.labelTextColor
                    //                    label.text = String(format: "%d", i+1)
                    var textString = ""
                    if self.labelPrefixText.isEmpty == false {
                        textString = self.labelPrefixText
                    }
                    textString = textString + " " + String(format: "%d", i+1)
                    if self.labelPostfixText.isEmpty == false {
                        textString = textString + " " + self.labelPostfixText
                    }
                    label.text = textString
                    
                    label.font = UIFont.boldSystemFont(ofSize: self.labelFontSize)
                }
            }else {
                xPos += width
            }
            
        }
        self.sliderScrollView.contentSize.width = xPos + self.sliderItemWidth / 2
        
        let boxFrame = CGRect(x: self.sliderLeftPadding, y: yAxis, width: self.frame.size.width - self.sliderLeftPadding - self.sliderRightPadding, height: self.frame.size.height - yAxis )
        let centerBox = UIView(frame: boxFrame)
        centerBox.backgroundColor = UIColor.clear
        self.addSubview(centerBox)
        centerBox.addGestureRecognizer(self.sliderScrollView.panGestureRecognizer)
    }
    internal func makeUIAsScale(view : UIView, part : Int) {
        var yPos : CGFloat = 0.0
        var xPos : CGFloat = 0.0
        let width : CGFloat = self.lineThikness
        let height : CGFloat = view.frame.size.height
        let dif = view.frame.size.width / CGFloat(part)
        for i in 0..<part {
            var newHeight = height
            if i == 0 {
                newHeight = newHeight * 0.75
            }else if i == 5 {
                newHeight = newHeight * 0.5
            }else {
                newHeight = newHeight * 0.25
            }
            yPos = height - newHeight
            let frameLine = CGRect(x: xPos, y: yPos, width: width, height: newHeight)
            let line = UIView(frame: frameLine)
            view.addSubview(line)
            xPos += dif
            line.backgroundColor = self.lineColor
        }
    }
    
    internal func reDrawArrow() {
        self.drawArrow(size: self.arrowSize, color: self.arrowColor!)
    }
    
    internal func drawArrow(size : CGFloat, color: UIColor) {
        
        //design the path
        let centerPoint = CGPoint(x: self.frame.size.width / 2, y: size + 2)
        let pointLeft = CGPoint(x: centerPoint.x - size/2, y: 2)
        let pointRight = CGPoint(x: centerPoint.x + size/2, y: 2)
        
        let path = UIBezierPath()
        path.move(to: pointLeft)
        path.addLine(to: pointRight)
        path.addLine(to: centerPoint)
        path.close()
        
        //design path in layer
        arrow = CAShapeLayer()
        arrow.path = path.cgPath
        arrow.strokeColor = color.cgColor
        arrow.fillColor = color.cgColor
        arrow.lineWidth = 1.0
        
        self.layer.addSublayer(arrow)
    }
    
    public func moveSliderToIndex(index : Int, withAnimation : Bool) {
        if index >= 0 && index <= self.sliderItemCount {
            self.currentIndex = index
            let x = self.sliderScrollView.frame.size.width * CGFloat(self.currentIndex)
            if withAnimation == true {
                UIView.animate(withDuration: 0.3, animations: {
                    self.sliderScrollView.contentOffset.x = x
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                    self.changeSelectedIndex(index: index)
                })
            }else{
                self.sliderScrollView.contentOffset.x = x
                self.changeSelectedIndex(index: index)
            }
            
            
        }else {
            print("Index Out Of Bound")
        }
        
    }
}


extension SJSliderView : UIScrollViewDelegate {
    public  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexOfPage = scrollView.contentOffset.x / scrollView.frame.size.width
        //your stuff with index
        
        self.setNeedsDisplay()
        self.changeSelectedIndex(index: Int(indexOfPage))
    }
    
    internal func changeSelectedIndex(index: Int) {
        self.currentIndex = index
//        print(self.currentIndex)
        if self.delegate != nil {
            self.delegate.didChangeSelectedIndex(index: index)
        }
        
    }
}
