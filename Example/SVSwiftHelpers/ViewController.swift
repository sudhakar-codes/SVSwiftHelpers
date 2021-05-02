//
//  ViewController.swift
//  SVSwiftHelpers
//
//  Created by sudhakar on 04/08/2021.
//  Copyright (c) 2021 sudhakar. All rights reserved.
//

import UIKit
import SVSwiftHelpers

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- Colour
    func colorExtensionExample() {
        
        print(UIColor(r:255, g:255, b:255, a:255))
        print(UIColor(hexString: "#00FF00") ?? .white)
        
        navigationBarColor = .randomColour
    }
    
    //MARK:- ViewController
    func viewControllerExtensionExample() {
        
        /// Alert
        showAlert("Title","Alert message", "OK")
        
        /// Alert style can be alert or actionSheet
        showAlertMoreThanOneButton("Title", "message", style: .actionSheet, actions:
                                    action("OK", preferredStyle: .default, action: { (action) in
                                        print("Cicked OK")
                                    }),
                                   action("Cancel", preferredStyle: .cancel, action: { (action) in
                                    print("Cicked Cancel")
                                   }),
                                   action("Delete", preferredStyle: .destructive, action: { (action) in
                                    print("Cicked delete")
                                   })
        )
        
        /// Navigation bar
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        print(tabBarHeight)
        print(navigationBarHeight)
        
        /// Can use in any view controller
        navigationTitleView(withTitle: "Title")
        navigationTitleView(withTitle: "Title",textColor: .blue)
        navigationTitleView(withTitle: "Title", subTitle: "Sub Title")
        navigationTitleView(withTitle: "Title", subTitle: "Sub Title",textColor :.red)
        
        /// Set navigation bar colour
        navigationBarColor = .randomColour
        
        presentVC(ViewController())
        pushVC(ViewController())
        popVC()
        popToRootVC()
        dismissVC { }
        
        /// Activity IndicatorView can be show in any view controller
        startActivityIndicator()
        /// can Show at any point in view
        startActivityIndicator(CGPoint(x: 10, y: 10))
        stopActivityIndicator()
        
        /// Open Safari
        openSFSafariVC(WithURL: "http://www.google.com")
        openSFSafariVC(WithURL: "http://www.google.com", barTint: .green)
    }
    
    //MARK:- String
    func stringExtensionExample()  {
        
        print("sudhakar".base64)
        print("sudhakar".length)
        print("9899898898".isValidMobileNumber)
        print("sudhakar@gmail.com".isValidEmail)
        print("http://www.google.com".isValidUrl)
        print("sudhakar  ".trim)
        print("<null>".validateEmptyString)
        print("sudhakar http://www.google.com , http://www.facebook.com".extractURLs)
        print("hello/there".split("/"))
        print("sudhakar".countofWords)
        print("sudhakar kjdh ksadh lash dljhal kda".countofParagraphs)
        print("sudhakar".countofWords)
        print("20".toInt ?? "")
        print("20".toFloat ?? "")
        print("20".toDouble ?? "")
        print("true".toBool ?? "")
        print("sudhakar".getIndexOf("a") ?? "")
        print("sudhakar".bold)
        print("sudhakar".italic)
        print("sudhakar".underline)
        print("sudhakar".height(view.frame.size.width, font: .systemFont(ofSize: 14), lineBreakMode: .byWordWrapping))
        print("sudhakar".color(.red))
        print("sudhakar Dasari".colorSubString("Dasari", color: .blue))
        print("http://www.google.com ".urlEncoded)
        
    }
    
    //MARK:- Date
    func dateExtensionExample() {
        
        let stringToDate = Date(fromString: "10-11-2020")
        print(stringToDate ?? Date())
        
        let httpsStringToDate = Date(httpDateString: "10-11-2020")
        print(httpsStringToDate ?? Date())
        
        let dateToString = Date().toString(format: "yyyy-MM-dd")
        print(dateToString)
        
        print(httpsStringToDate?.timeAgoSinceDate ?? "")
        
        print(httpsStringToDate?.daysInBetweenDate(Date()) ?? "")
        print(httpsStringToDate?.hoursInBetweenDate(Date()) ?? "")
        print(httpsStringToDate?.minutesInBetweenDate(Date()) ?? "")
        print(httpsStringToDate?.secondsInBetweenDate(Date()) ?? "")
        print(httpsStringToDate?.hoursInBetweenDate(Date()) ?? "")
        
        print(httpsStringToDate?.years(from: Date()) ?? "")
        print(httpsStringToDate?.months(from: Date()) ?? "")
        print(httpsStringToDate?.weeks(from: Date()) ?? "")
        print(httpsStringToDate?.days(from: Date()) ?? "")
        print(httpsStringToDate?.hours(from: Date()) ?? "")
        print(httpsStringToDate?.minutes(from: Date()) ?? "")
        print(httpsStringToDate?.seconds(from: Date()) ?? "")
        
        print(httpsStringToDate?.offset(from: Date()) ?? "")
        
        print(httpsStringToDate?.timeAgoSinceDate ?? "")
        
        print(httpsStringToDate?.isFuture ?? false)
        print(httpsStringToDate?.isPast ?? false)
        print(httpsStringToDate?.isToday ?? false)
        print(httpsStringToDate?.isYesterday ?? false)
        print(httpsStringToDate?.isTomorrow ?? false)
        print(httpsStringToDate?.isThisMonth ?? false)
        print(httpsStringToDate?.isThisWeek ?? false)
        print(httpsStringToDate?.isPast ?? false)
        print(httpsStringToDate?.isPast ?? false)
        print(httpsStringToDate?.isPast ?? false)
        
        print(httpsStringToDate?.era ?? "")
        print(httpsStringToDate?.year ?? "")
        print(httpsStringToDate?.month ?? "")
        print(httpsStringToDate?.day ?? "")
        print(httpsStringToDate?.hour ?? "")
        print(httpsStringToDate?.minute ?? "")
        print(httpsStringToDate?.second ?? "")
        print(httpsStringToDate?.nanosecond ?? "")
        print(httpsStringToDate?.weekday ?? "")
        print(httpsStringToDate?.monthAsString ?? "")
        
        print(Date().changeDaysBy(days: 5))
        print(Date().from(year: 1, month: 1, day: 1) ?? "")
        
    }
    
    //MARK:- App
    func appHelperExample()  {
        
        /// Get all your app details
        print(App.macAddress ?? "")
        print(App.name ?? "")
        print(App.version ?? "")
        print(App.formattedNameAndVersion ?? "")
        print(App.systemVersion ?? "")
    }
    
    //MARK:- UIView
    func viewExtensionExample()  {
        
        let sampleView = UIView(x: 1, y: 1, w: 1, h: 1)
        
        sampleView.addSubviews([UIView(),UIView()])
        
        print(sampleView.x) // get
        sampleView.x = 10 // set
        
        sampleView.roundView()
        sampleView.roundCorners([UIRectCorner.topLeft, UIRectCorner.topRight], radius: 1.0)
        
        sampleView.setCornerRadius(radius: 3.0)
        sampleView.addShadow(offset: CGSize(width: 0, height: 1.0), radius: 1.0, color: .black, opacity: 1.0)
        sampleView.addBorder(width: 1.0, color: .red)
        sampleView.drawCircle(fillColor: .white, strokeColor: .red, strokeWidth: 0.5)
        sampleView.drawStroke(width: 1.0, color: .red)
        
    }
    
    //MARK:- UserDefaults
    func userdefaultsExtensionExample() {
        
        //setter
        UserDefaults.standard["sudhakar"]  = "name"
        
        // Getter
        let name = UserDefaults.standard["name"]
        print(name!)
        
        if UserDefaults.standard.valueExists(forKey: "name") {
            print("value exits")
        }
        
        UserDefaults.standard.archive(object: [:], forKey: "data")
        
        print(UserDefaults.standard.unarchivedObject(forKey: "data") as? [String:Any] ?? [:])
        
    }
    
    //MARK:- UITextField
    
    func textFieldExtensionExample()  {
        
        let textField = UITextField(x: 0, y: 0, w: 100, h: 44)
        
        textField.addLeftTextPadding(5.0)
        textField.addLeftIcon(nil, frame: CGRect(x: 10, y: 10, width: 10, height: 10), imageSize: CGSize(width: 10, height: 10))
        textField.addRightIcon(nil, frame: CGRect(x: 10, y: 10, width: 10, height: 10), imageSize: CGSize(width: 10, height: 10))
        
        textField.enablePasswordToggle()
        
    }
    
    //MARK:- UILabel
    func labelExtensionExample() {
        
        let label = UILabel(x: 0, y: 0, w: 100, h: 200)
        
        label.set(image: UIImage(named: "image")!, with: "Hello world")
    }
    
    //MARK:- UIImageView
    func imageViewExtensionExample() {
        
        let imageView = UIImageView(x: 0, y: 0, w: 120, h: 100)
        
        imageView.image = imageView.changeImageColor(color: .red)
    }
    
    //MARK:- UIFont
    
    func fontExtensionExample() {
        
        let font = UIFont.Font(name: .Helvetica, type: .Light, size: 14)
        print(font)
        
        let customFont = UIFont.customFont(name: "fontname", type: .Light, size: 12)
        print(customFont)
        
        print(UIFont.openSansFontLight(ofSize: 14))
        print(UIFont.openSansFontRegular(ofSize: 14))
        print(UIFont.openSansFontSemiBold(ofSize: 14))
        print(UIFont.openSansFontBold(ofSize: 14))
    }
    
}

