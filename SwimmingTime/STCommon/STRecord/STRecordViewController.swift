//
//  STRecordViewController.swift
//  SwimmingTime
//
//  Created by 龚梦洋 on 2023/7/27.
//

import Foundation
import UIKit

class STRecordViewController: UIViewController {
    
    private var dataSource: [STRecordModel] = []
    
    private lazy var nullLabel: UILabel = {
        let label = UILabel()
        label.text = "There is no record yet~"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "topImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var privacyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "quanxian"), for: .normal)
        button.addTarget(self, action: #selector(privacyEvent), for: .touchUpInside)
        return button
    }()
    
    private lazy var recordTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(RecordCell.self, forCellReuseIdentifier: "RecordCell")
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataSource = STRecordManager.shared.getRecordInfo()
        recordTableView.reloadData()
        if dataSource.isEmpty {
            recordTableView.isHidden = true
            nullLabel.isHidden = false
        } else {
            nullLabel.isHidden = true
            recordTableView.isHidden = false
        }
    }
    
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
        
        topImageView.addSubview(privacyButton)
        privacyButton.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.bottom.equalTo(-12)
            make.left.equalTo(20)
        }
        
        view.addSubview(recordTableView)
        recordTableView.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-(kTabbarHeight))
        }
        
        view.addSubview(nullLabel)
        nullLabel.snp.makeConstraints { make in
            make.center.equalTo(recordTableView)
        }
    }
    
    @objc func privacyEvent() {
        let vc = STPrivacyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension STRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as? RecordCell
        cell?.record = dataSource[indexPath.row]
        return cell ?? RecordCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65 + 16
    }
    
}

class RecordCell: UITableViewCell {
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = kColor(r: 255, g: 255, b: 255, 0.3)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var distanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Distance"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var speedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Speed"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var speedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        bgView.addSubview(timeTitleLabel)
        timeTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo((stScreenWidth - 40) / 3)
            make.height.equalTo(30)
        }
        
        bgView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.width.equalTo((stScreenWidth - 40) / 3)
            make.height.equalTo(30)
        }
        
        bgView.addSubview(distanceTitleLabel)
        distanceTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(timeTitleLabel.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo((stScreenWidth - 40) / 3)
            make.height.equalTo(30)
        }
        
        bgView.addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { make in
            make.left.equalTo(timeLabel.snp.right)
            make.bottom.equalToSuperview()
            make.width.equalTo((stScreenWidth - 40) / 3)
            make.height.equalTo(30)
        }
        
        bgView.addSubview(speedTitleLabel)
        speedTitleLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.left.equalTo(distanceTitleLabel.snp.right)
            make.height.equalTo(30)
        }
        
        bgView.addSubview(speedLabel)
        speedLabel.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.left.equalTo(distanceLabel.snp.right)
            make.height.equalTo(30)
        }
    }
    
    var record: STRecordModel? {
        didSet {
            if let record = record {
                timeLabel.text = record.timeStrig
                distanceLabel.text = String(format: "%dm", record.distance ?? 1)
                speedLabel.text = record.speed
            }
        }
    }
}
