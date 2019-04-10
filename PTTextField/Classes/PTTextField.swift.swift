//
//  PTTextField.swift
//  Pantip
//
//  Created by Komkrit Siratitanan on 4/4/2562 BE.
//  Copyright © 2562 InternetMarketing. All rights reserved.
//

import Foundation
import UIKit

open class PTTextField: UITextField {
    var bIsShowing: Bool!
    
    var mView: UIView!
    var mLabel: UILabel!
    var tintedClearImage: UIImage?
    var tintedClearHighLightedImage: UIImage?
    
    private var sRegEX: String = ""
    public var regEX: String! {
        get {
            return self.sRegEX
        }
        set {
            self.sRegEX = newValue
        }
    }
    
    private var sTextShow: String = ""
    public var textShow: String! {
        get {
            return self.sTextShow
        }
        set {
            self.sTextShow = newValue
        }
    }
    
    private var oCorrectColor: UIColor = .green
    public var correctColor: UIColor! {
        get {
            return self.oCorrectColor
        }
        set {
            self.oCorrectColor = newValue
        }
    }
    
    private var oWrongColor: UIColor = .red
    public var wrongColor: UIColor! {
        get {
            return self.oWrongColor
        }
        set {
            self.oWrongColor = newValue
        }
    }
    
    private var oBGColor: UIColor = .white
    public var BGColor: UIColor! {
        get {
            return self.oBGColor
        }
        set {
            self.oBGColor = newValue
            self.mView.backgroundColor = self.oBGColor
            self.backgroundColor = self.oBGColor
        }
    }
    
    private var oFontColor: UIColor = .gray
    public var fontColor: UIColor! {
        get {
            return self.oFontColor
        }
        set {
            self.oFontColor = newValue
            self.mLabel.textColor = self.oFontColor
        }
    }
    
    private var oPlaceHolderColor: UIColor = .gray
    public var placeHolderColor: UIColor! {
        get {
            return self.oPlaceHolderColor
        }
        set {
            self.oPlaceHolderColor = newValue
        }
    }
    
    private var oFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    public var textFont: UIFont! {
        get {
            return self.oFont
        }
        set {
            self.oFont = newValue
        }
    }
    
    private var oBorderColor: UIColor = .gray
    public var borderColor: UIColor! {
        get {
            return self.oBorderColor
        }
        set {
            self.oBorderColor = newValue
            self.layer.borderColor = self.oBorderColor.cgColor
        }
    }
    
    private var oCornerRadius: CGFloat = 10.0
    public var cornerRadius: CGFloat! {
        get {
            return self.oCornerRadius
        }
        set {
            self.oCornerRadius = newValue
            self.layer.cornerRadius = self.oCornerRadius
        }
    }
    
    private var oBorderWidth: CGFloat = 1.0
    public var borderWidth: CGFloat! {
        get {
            return self.oBorderWidth
        }
        set {
            self.oBorderWidth = newValue
            self.layer.borderWidth = self.oBorderWidth
        }
    }
    
    private var oTextColor: UIColor = .gray
    public var fontTextColor: UIColor! {
        get {
            return self.oTextColor
        }
        set {
            self.oTextColor = newValue
            self.textColor = self.oTextColor
        }
    }
    
    private var oClearBtnColor: UIColor = .gray
    public var clearBtnColor: UIColor! {
        get {
            return self.oClearBtnColor
        }
        set {
            self.oClearBtnColor = newValue
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.bIsShowing = false
        self.sRegEX = ""
        self.mView = UIView()
        self.mLabel = UILabel()
    }
    
    public func setupPTTextField() {
        self.textColor = self.oTextColor
        self.layer.borderWidth = self.oBorderWidth
        self.layer.cornerRadius = self.oCornerRadius
        self.layer.borderColor = self.oBorderColor.cgColor
        self.mLabel.textColor = self.oFontColor
        self.mView.backgroundColor = self.oBGColor
        self.backgroundColor = self.oBGColor
        
        self.autocorrectionType = .no
        self.clearButtonMode = .whileEditing
        self.attributedPlaceholder = NSAttributedString(
            string: self.sTextShow,
            attributes: [
                NSAttributedString.Key.foregroundColor: self.oPlaceHolderColor,
                NSAttributedString.Key.font: self.oFont
            ]
        )
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.tintClearImage()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8.0, dy: 10.0)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 18.0, dy: 14.0)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8.0, dy: 10.0)
    }
    
    private func getWidthSize(fSize: CGFloat) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: self.oFont.withSize(fSize)]
        let size = self.sTextShow.size(withAttributes: fontAttributes)
        return size.width
    }
    
    public func setPTTextFieldColor(oFontColor: UIColor = .gray, oBorderColor: UIColor = .gray) {
        self.layer.borderColor = oBorderColor.cgColor
        self.mLabel.textColor = oFontColor
    }
    
    private func VerifyText(oCorrectColor: UIColor, oWrongColor: UIColor, sTextCheck: String , sRegex: String) {
        if let _ = sTextCheck.range(of:sRegex, options: .regularExpression) {
            self.layer.borderColor = oCorrectColor.cgColor
        } else {
            self.layer.borderColor = oWrongColor.cgColor
        }
    }
    
    private func tintClearImage() {
        for view in subviews {
            if view is UIButton {
                let button = view as! UIButton
                if let uiImage = button.image(for: .highlighted) {
                    if self.tintedClearImage == nil {
                        self.tintedClearImage = self.tintImage(image: uiImage, color: self.oClearBtnColor)
                    }
                    if self.tintedClearHighLightedImage == nil {
                        self.tintedClearHighLightedImage = self.tintImage(image: uiImage, color: self.oClearBtnColor)
                    }
                    button.setImage(self.tintedClearImage, for: .normal)
                    button.setImage(self.tintedClearHighLightedImage, for: .highlighted)
                }
            }
        }
    }
    
    private func tintImage(image: UIImage, color: UIColor) -> UIImage {
        let size = image.size
        
        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        image.draw(at: CGPoint.zero, blendMode: CGBlendMode.normal, alpha: 1.0)
        
        context?.setFillColor(color.cgColor)
        context?.setBlendMode(CGBlendMode.sourceIn)
        context!.setAlpha(1.0)
        
        let rect = CGRect(x: CGPoint.zero.x, y: CGPoint.zero.y, width: image.size.width, height: image.size.height)
        UIGraphicsGetCurrentContext()!.fill(rect)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintedImage!
    }
}

extension PTTextField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let sTxt: String = "\(String(textField.text!))\(string)"
        if !self.sRegEX.isEmpty {
            self.VerifyText(oCorrectColor: self.oCorrectColor, oWrongColor: self.oWrongColor, sTextCheck: sTxt, sRegex: self.sRegEX)
        }
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.placeholder = ""
        self.superview?.addSubview(self.mView)
        self.mView.addSubview(self.mLabel)
        
        self.mView.backgroundColor = self.oBGColor
        if self.text!.isEmpty {
            self.mView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y + (self.frame.size.height / 4), width: self.getWidthSize(fSize: self.oFont.pointSize) + 16.0, height: (self.frame.size.height / 2))
        } else {
            self.mView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y - (self.frame.size.height / 4), width: self.getWidthSize(fSize: ((self.oFont.pointSize * 75) / 100)) + 8.0, height: (self.frame.size.height / 2))
        }
        
        self.mLabel.text = self.sTextShow
        self.mLabel.font = self.oFont
        self.mLabel.textAlignment = .center
        
        self.mLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mLabel.leftAnchor.constraint(equalTo: self.mView.leftAnchor, constant: 4.0).isActive = true
        self.mLabel.rightAnchor.constraint(equalTo: self.mView.rightAnchor, constant: -4.0).isActive = true
        self.mLabel.centerYAnchor.constraint(equalTo: self.mView.centerYAnchor).isActive = true
        
        if self.text!.isEmpty {
            UIView.animate(withDuration: 0.25, animations: {
                self.bIsShowing = true
                self.mView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y - (self.frame.size.height / 4), width: self.getWidthSize(fSize: ((self.oFont.pointSize * 75) / 100)) + 8.0, height: (self.frame.size.height / 2))
                UIView.transition(with: self.mLabel, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.mLabel.textColor = self.oFontColor
                }, completion: nil)
            }) { (complete) in
                self.bIsShowing = false
            }
        }
    }
    
    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        UIView.animate(withDuration: 0.25, animations: {
            self.bIsShowing = true
            if self.text!.isEmpty {
                self.mView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y + (self.frame.size.height / 4), width: self.getWidthSize(fSize: self.oFont.pointSize) + 16.0, height: (self.frame.size.height / 2))
                UIView.transition(with: self.mLabel, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.mLabel.textColor = self.oFontColor
                }, completion: nil)
            }
        }) { (complete) in
            if self.text!.isEmpty {
                self.mView.removeFromSuperview()
            }
            self.attributedPlaceholder = NSAttributedString(
                string: self.sTextShow,
                attributes: [
                    NSAttributedString.Key.foregroundColor: self.oPlaceHolderColor,
                    NSAttributedString.Key.font: self.oFont
                ]
            )
            self.bIsShowing = false
        }
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return !self.bIsShowing
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return !self.bIsShowing
    }
}
