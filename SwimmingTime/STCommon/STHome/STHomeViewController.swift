//
//  STHomeViewController.swift
//  SwimmingTime
//
//  Created by 龚梦洋 on 2023/7/27.
//

import Foundation
import UIKit
import SnapKit

class STHomeViewController: UIViewController {
    
    private var timer: Timer?
    private var minutes: Int = 0
    private var seconds: Int = 0
    private var millionSeconds: Int = 0
    
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "topImage"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var clockImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "clock"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .white
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var distanceView: UIView = {
        let view = UIView()
        view.backgroundColor = kColor(r: 255, g: 255, b: 255, 0.3)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var distanceTextFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.textAlignment = .center
        textFiled.textColor = .white
        textFiled.font = .systemFont(ofSize: 24, weight: .bold)
        textFiled.keyboardType = .numberPad
        return textFiled
    }()
    
    private lazy var distanceUnitLabel: UILabel = {
        let label = UILabel()
        label.text = "m"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .medium)
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(self.imageWithColor(color: kColor(r: 105, g: 173, b: 250)), for: .normal)
        button.setBackgroundImage(self.imageWithColor(color: kColor(r: 255, g: 71, b: 71)), for: .selected)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Stop", for: .selected)
        button.setTitleColor(UIColor.white, for: .selected)
        button.layer.cornerRadius = 50
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 8
        button.addTarget(self, action: #selector(startAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = bgColor
        
        view.addSubview(topImageView)
        topImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(stScreenHeight / 5)
        }
        
        view.addSubview(clockImage)
        clockImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(300)
            make.top.equalTo(topImageView.snp.bottom).offset(20)
        }
        
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.edges.equalTo(clockImage)
        }
        
        view.addSubview(distanceView)
        distanceView.snp.makeConstraints { make in
            make.top.equalTo(clockImage.snp.bottom).offset(24)
            make.width.equalTo(94)
            make.height.equalTo(44)
            make.centerX.equalToSuperview().offset(-8)
        }
        
        distanceView.addSubview(distanceTextFiled)
        distanceTextFiled.snp.makeConstraints { make in
            make.top.left.equalTo(4)
            make.bottom.right.equalTo(-4)
        }
        
        view.addSubview(distanceUnitLabel)
        distanceUnitLabel.snp.makeConstraints { make in
            make.left.equalTo(distanceView.snp.right).offset(2)
            make.height.equalTo(22)
            make.width.equalTo(30)
            make.top.equalTo(distanceView.snp.centerY)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(-(kTabbarHeight + 40))
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func startAction(sender: UIButton) {
        if (!distanceTextFiled.hasText || Int(distanceTextFiled.text ?? "0") == 0) {
            STToolsManager.showMessage("Please input the kilometer number.", vc: self)
            return
        }
        sender.isSelected = !sender.isSelected
        if (sender.isSelected) {
            setupTimer()
        } else {
            distanceTextFiled.resignFirstResponder()
            releaseTimer()
            save()
            distanceTextFiled.text = ""
            minutes = 0
            seconds = 0
            millionSeconds = 0
            timeLabel.text = "00:00:00"
        }
    }
    
    private func setupTimer() {
        timer = Timer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    private func releaseTimer() {
        if (timer == nil) {
            return
        }
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerAction() {
        millionSeconds += 1
        if (millionSeconds >= 100) {
            seconds += 1
            millionSeconds = 0
        }
        if (seconds == 60) {
            minutes += 1
            seconds = 0
        }
        let timeString = String(format: "%02d:%02d:%02d", minutes, seconds, millionSeconds)
        self.timeLabel.text = timeString
    }
    
    private func save() {
        let time = minutes * 60 + seconds
        let distance = Int(distanceTextFiled.text ?? "0") ?? 1
        let speed = Double(time) / Double(distance)
        let model = STRecordModel()
        model.timeStrig = timeLabel.text
        model.distance = Int(distanceTextFiled.text ?? "0") ?? 1
        model.speed = String(format: "%.2fm/s", speed)
        STRecordManager.shared.saveRecordInfo(model)
        STToolsManager.showMessage("This data has been recorded.", vc: self)
    }
    
    private func imageWithColor(color:UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
