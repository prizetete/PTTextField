//
//  PTTextField.swift
//  IntroducePaiApp
//
//  Created by Komkrit Siratitanan on 2/4/2562 BE.
//  Copyright © 2562 Komkrit Siratitanan. All rights reserved.
//

import Foundation
import UIKit

public class PTTextField: UITextField {
    public var mView: UIView!
    public var mLabel: UILabel!
    
    public var sRegEX: String!
    public var sTextShow: String! = ""
    
    public var oBorderColor: UIColor!
    public var oCorrectColor: UIColor!
    public var oWrongColor: UIColor!
    public var oBGColor: UIColor!
    public var oFontColor: UIColor!
    public var oPlaceHolderColor: UIColor!
    
    public var bVerify: Bool!
    public var bIsShowing: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.bVerify = false
        self.bIsShowing = false
        self.sRegEX = ""
        self.mView = UIView()
        self.mLabel = UILabel()
    }
    
    public func setupPTTextField(sTextShow: String, oBGColor: UIColor = .white, oPlaceHolderColor: UIColor = .gray, oFontColor: UIColor = .gray, sRegEX: String = "", oCorrectColor: UIColor = .green, oWrongColor: UIColor = .red, cornerRadius: CGFloat = 10.0, borderColor: UIColor = .gray, borderWidth: CGFloat = 1.0) {
        self.sTextShow = sTextShow
        self.oBorderColor = borderColor
        self.oFontColor = oFontColor
        self.oPlaceHolderColor = oPlaceHolderColor
        self.oBGColor = oBGColor
        self.oWrongColor = oWrongColor
        self.oCorrectColor = oCorrectColor
        self.sRegEX = sRegEX
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.attributedPlaceholder = NSAttributedString(
            string: self.sTextShow,
            attributes: [
                NSAttributedString.Key.foregroundColor: self.oPlaceHolderColor,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)
            ]
        )
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10.0, dy: 10.0)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14.0, dy: 14.0)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10.0, dy: 10.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getWidthSize(fSize: CGFloat) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fSize)]
        let size = self.sTextShow.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func setPTTextFieldColor(oFontColor: UIColor = .gray, oBorderColor: UIColor = .gray) {
        self.layer.borderColor = oBorderColor.cgColor
        self.mLabel.textColor = oFontColor
    }
    
    func VerifyText(oCorrectColor: UIColor, oWrongColor: UIColor, sTextCheck: String , sRegex: String) {
        if let _ = sTextCheck.range(of:sRegex, options: .regularExpression) {
            self.layer.borderColor = oCorrectColor.cgColor
        } else {
            self.layer.borderColor = oWrongColor.cgColor
        }
    }
}

@available(iOS 9.0, *)
extension PTTextField: UITextFieldDelegate {
    private func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let sTxt: String = "\(String(textField.text!))\(string)"
        if !self.sRegEX.isEmpty {
            self.VerifyText(oCorrectColor: self.oCorrectColor, oWrongColor: self.oWrongColor, sTextCheck: sTxt, sRegex: self.sRegEX)
        }
        return true
    }
    
    private func textFieldDidBeginEditing(_ textField: UITextField) {
        self.placeholder = ""
        self.superview?.addSubview(self.mView)
        self.mView.addSubview(self.mLabel)
        
        self.mView.backgroundColor = self.oBGColor
        if self.text!.isEmpty {
            self.mLabel.textColor = self.oPlaceHolderColor
            self.mView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y + (self.frame.size.height / 4), width: self.getWidthSize(fSize: 16.0) + 8, height: (self.frame.size.height / 2))
        } else {
            self.mLabel.textColor = self.oFontColor
            self.mView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y - (self.frame.size.height / 4), width: self.getWidthSize(fSize: 12.0), height: (self.frame.size.height / 2))
        }
        
        self.mLabel.text = self.sTextShow
        self.mLabel.font = .systemFont(ofSize: 16.0)
        self.mLabel.textAlignment = .left
        
        self.mLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mLabel.leftAnchor.constraint(equalTo: self.mView.leftAnchor, constant: 4.0).isActive = true
        self.mLabel.rightAnchor.constraint(equalTo: self.mView.rightAnchor, constant: -4.0).isActive = true
        self.mLabel.centerYAnchor.constraint(equalTo: self.mView.centerYAnchor).isActive = true
        
        if self.text!.isEmpty {
            UIView.animate(withDuration: 0.25, animations: {
                self.bIsShowing = true
                self.mView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y - (self.frame.size.height / 4), width: self.getWidthSize(fSize: 12.0), height: (self.frame.size.height / 2))
                UIView.transition(with: self.mLabel, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.mLabel.textColor = self.oFontColor
                }, completion: nil)
            }) { (complete) in
                self.bIsShowing = false
            }
        }
    }
    
    @available(iOS 10.0, *)
    private func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        UIView.animate(withDuration: 0.25, animations: {
            self.bIsShowing = true
            if self.text!.isEmpty {
                self.mView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.mView.frame = CGRect(x: textField.frame.origin.x + 10.0, y: textField.frame.origin.y + (self.frame.size.height / 4), width: self.getWidthSize(fSize: 16.0) + 8.0, height: (self.frame.size.height / 2))
                UIView.transition(with: self.mLabel, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.mLabel.textColor = self.oPlaceHolderColor
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
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)
                ]
            )
            self.layer.borderColor = self.oBorderColor.cgColor
            self.bIsShowing = false
        }
    }
    
    private func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return !self.bIsShowing
    }
    
    private func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return !self.bIsShowing
    }
}
