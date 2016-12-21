//
//  CustomTextField.swift
//  BusinessOS
//
//  Created by Jian Zhang on 10/27/15.
//  Copyright © 2015 PwC. All rights reserved.
//

import UIKit

class CustomTextField: UIView, UITextFieldDelegate {
    
    var title : String = ""
    var strValue : String = ""
    var bolEdited : Bool = false
    var bolTextfield : Bool = true
    var isOptional : Bool = false
    
    let editedColor = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
    let uneditedColor = UIColor.lightGray
    let fieldColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
    
    let editedInterval : CGFloat = 20
    let uneditedInterval : CGFloat = 10
    
    let editedFont : CGFloat = 11
    let uneditedFont : CGFloat = 14
    
    var tapHandler : ButtonTouchUpBlock?
    var finishEditHandler : TextFieldFinishBlock?
    var itemSelectHandler : ReturnBlock?
    var startHandler : TextFieldStartBlock?
    
    var leaveHandler : TextFieldLeaveBlock?
    var returnhandler : TextFieldReturnBlock?
    
    @IBOutlet weak var bottomLineInterval: NSLayoutConstraint!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var fieldTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    
    func createCustomField(_title : String, _bolTextfield : Bool)
    {
        fieldTF.delegate = self
        fieldTF.textColor = fieldColor
        
        fieldTF.autocorrectionType = UITextAutocorrectionType.no

        title = _title
        bolTextfield = _bolTextfield
        self.titleLbl.text = _title
        errorLbl.isHidden = true
    }
    
    func setText(str : String)
    {
        strValue = str
        fieldTF.text = str
        animationTitleLbl(bol: true)
    }
    
    func showErrorMsg(str : String)-> Void
    {
        errorLbl.isHidden = false
        errorLbl.text = str
    }
    
    func setValueField(str : String)
    {
        self.strValue = str
        self.fieldTF.text = str
        self.animationTitleLbl(bol: true)
    }
    
    func animationTitleLbl(bol : Bool){
        bolEdited = bol
        if bolEdited
        {
            bottomLineView.backgroundColor = editedColor
            titleLbl.textColor = editedColor
            self.titleLbl.font = UIFont.systemFont(ofSize: self.editedFont)
//            titleLbl.text = title.stringByReplacingOccurrencesOfString("(optional)", withString: "")
            if self.bottomLineInterval.constant != self.editedInterval
            {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.bottomLineInterval.constant = self.editedInterval
                    self.layoutIfNeeded()
                })
            }
        }
        else
        {
            if fieldTF.text?.characters.count != 0
            {
                titleLbl.text = title
            }
            else
            {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.bottomLineInterval.constant = self.uneditedInterval
                    self.layoutIfNeeded()
                    }, completion: { (bol) -> Void in
                })
            }
            titleLbl.textColor = uneditedColor
            bottomLineView.backgroundColor = uneditedColor

        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        bolEdited = true
        errorLbl.isHidden = true
        animationTitleLbl(bol: bolEdited)
        
        if self.tapHandler != nil
        {
            self.tapHandler?()
        }
        if startHandler != nil
        {
            startHandler?()
        }
        return bolTextfield
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let prospectiveText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        strValue = prospectiveText
        if finishEditHandler != nil
        {
            finishEditHandler!(prospectiveText)
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        bolEdited = false
        if finishEditHandler != nil
        {
            finishEditHandler!(strValue)
        }
        if leaveHandler != nil
        {
            leaveHandler?(textField.text!)
        }
        animationTitleLbl(bol: bolEdited)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UIApplication.shared.keyWindow?.endEditing(true)
        if returnhandler != nil
        {
            returnhandler!()
        }
        return true
    }
    func hidePassword(hide: Bool){
        fieldTF.isSecureTextEntry = hide
        
    }
}
