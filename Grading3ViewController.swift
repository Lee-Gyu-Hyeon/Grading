//
//  Grading3ViewController.swift
//  ggoggosynchro
//
//  Created by lee gyuhyeon on 9/18/25.
//

import UIKit
import Alamofire
import SwiftyJSON
import CryptoSwift

class Grading3ViewController: UIViewController, AlreadyRegisteredScoreViewControllerDelegate {

    let dimmedView = UIView()
    let bottomSheetView = UIView()
    
    let ScoringTitleLabel = UILabel()
    let closeButton = UIButton()
    
    let blueBox = UIView()
    let AIScoreIconImage = UIImageView()
    let AIScoreTitleLabel = UILabel()
    let AIScoreLabel = UILabel()
    
    let blueBox2 = UIView()
    let JudgeScoreIconImage = UIImageView()
    let JudgeScoreTitleLabel = UILabel()
    let JudgeScoreLabel = UILabel()
    
    let blueBox3 = UIView()
    let AverageScoreIconImage = UIImageView()
    let AverageScoreTitleLabel = UILabel()
    let AverageScoreLabel = UILabel()
    
    let SendAuthenticationCodeButton = UIButton()
    var data5: ListContentM!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        dimmedView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        dimmedView.alpha = 0.0
        
        bottomSheetView.backgroundColor = .white
        bottomSheetView.clipsToBounds = true
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.layer.cornerRadius = 6
        
        
        //ScoringTitleLabel.text = "채점하기"
        ScoringTitleLabel.text = "콘텐츠 점수"
        //ScoringTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        ScoringTitleLabel.font = UIFont(name: "KoPubWorldDotumBold", size: 20)
        ScoringTitleLabel.adjustsFontSizeToFitWidth = true
        
        ScoringTitleLabel.textColor = UIColor(red: 62/255, green: 202/255, blue: 192/255, alpha: 1.0)
        bottomSheetView.addSubview(ScoringTitleLabel)
        
        ScoringTitleLabel.snp.makeConstraints{ (make) in
            make.leading.equalTo(29)
            make.top.equalToSuperview().offset(36)
        }
        
        
        closeButton.setImage(UIImage(named: "img_btn_givescore_close"), for: .normal)
        closeButton.setImage(UIImage(named: "img_btn_ranking_close"), for: .selected)
        closeButton.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
        bottomSheetView.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(-17)
            make.width.height.equalTo(14)
            make.top.equalTo(12)
        }
        
        
        blueBox.backgroundColor = UIColor.white
        /*blueBox.layer.borderWidth = 1
        blueBox.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor*/
        bottomSheetView.addSubview(blueBox)
        
        blueBox.snp.makeConstraints { (make) in
            make.leading.equalTo(28)
            make.trailing.equalTo(-28)
            make.height.equalTo(31)
            make.top.equalTo(ScoringTitleLabel.snp.bottom).offset(12)
        }
        
        
        AIScoreIconImage.image = UIImage(named: "img_ic_grading_ai2")
        blueBox.addSubview(AIScoreIconImage)
        
        AIScoreIconImage.snp.makeConstraints { (make) in
            make.leading.equalTo(2)
            make.top.equalTo(5)
        }
        
        
        AIScoreTitleLabel.text = "AI 점수"
        //AIScoreTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        AIScoreTitleLabel.font = UIFont(name: "KoPubWorldDotumBold", size: 16)
        blueBox.addSubview(AIScoreTitleLabel)
        
        AIScoreTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(7)
            make.leading.equalTo(AIScoreIconImage.snp.trailing).offset(5)
        }
        
        
        //AIScoreLabel.text = "100점"
        //AIScoreLabel.font = UIFont.boldSystemFont(ofSize: 18)
        AIScoreLabel.font = UIFont(name: "KoPubWorldDotumBold", size: 20)
        AIScoreLabel.adjustsFontSizeToFitWidth = true
        blueBox.addSubview(AIScoreLabel)
        
        AIScoreLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(-1)
            //make.centerY.equalToSuperview()
            make.top.equalTo(1)
        }
        
        
        blueBox2.backgroundColor = UIColor.white
        /*blueBox2.layer.borderWidth = 1
        blueBox2.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor*/
        bottomSheetView.addSubview(blueBox2)
        
        blueBox2.snp.makeConstraints { (make) in
            make.leading.equalTo(28)
            make.trailing.equalTo(-28)
            make.height.equalTo(31)
            make.top.equalTo(blueBox.snp.bottom).offset(18)
        }
        
        
        JudgeScoreIconImage.image = UIImage(named: "img_ic_judgescoring2")
        blueBox2.addSubview(JudgeScoreIconImage)
        
        JudgeScoreIconImage.snp.makeConstraints { (make) in
            make.leading.equalTo(2)
            make.top.equalTo(6)
        }
        
        
        JudgeScoreTitleLabel.text = "심사위원 점수"
        //JudgeScoreTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        JudgeScoreTitleLabel.font = UIFont(name: "KoPubWorldDotumBold", size: 16)
        JudgeScoreTitleLabel.adjustsFontSizeToFitWidth = true
        blueBox2.addSubview(JudgeScoreTitleLabel)
        
        JudgeScoreTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(JudgeScoreIconImage.snp.trailing).offset(2)
            make.top.equalTo(5)
        }
        
        
        //JudgeScoreLabel.text = "100점"
        //JudgeScoreLabel.font = UIFont.boldSystemFont(ofSize: 18)
        JudgeScoreLabel.font = UIFont(name: "KoPubWorldDotumBold", size: 20)
        JudgeScoreLabel.adjustsFontSizeToFitWidth = true
        blueBox2.addSubview(JudgeScoreLabel)
        
        JudgeScoreLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(-1)
            make.centerY.equalToSuperview()
        }
        
        
        blueBox3.backgroundColor = UIColor.white
        /*blueBox3.layer.borderWidth = 1
        blueBox3.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor*/
        bottomSheetView.addSubview(blueBox3)
        
        blueBox3.snp.makeConstraints { (make) in
            make.leading.equalTo(28)
            make.trailing.equalTo(-28)
            make.height.equalTo(31)
            make.top.equalTo(blueBox2.snp.bottom).offset(16)
        }
        
        
        AverageScoreIconImage.image = UIImage(named: "img_ic_averagescore2")
        blueBox3.addSubview(AverageScoreIconImage)
        
        AverageScoreIconImage.snp.makeConstraints { (make) in
            make.leading.equalTo(2)
            make.top.equalTo(8)
        }
        
        
        AverageScoreTitleLabel.text = "평균 점수"
        //AverageScoreTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        AverageScoreTitleLabel.font = UIFont(name: "KoPubWorldDotumBold", size: 16)
        AverageScoreLabel.adjustsFontSizeToFitWidth = true
        blueBox3.addSubview(AverageScoreTitleLabel)
        
        AverageScoreTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(AverageScoreIconImage.snp.trailing).offset(6)
            make.top.equalTo(7)
        }
        
        
        //AverageScoreLabel.text = "100점"
        //AverageScoreLabel.font = UIFont.boldSystemFont(ofSize: 18)
        AverageScoreLabel.font = UIFont(name: "KoPubWorldDotumBold", size: 20)
        blueBox3.addSubview(AverageScoreLabel)
        
        AverageScoreLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(-1)
            //make.centerY.equalToSuperview()
            make.top.equalTo(2)
        }
        
        
        //SendAuthenticationCodeButton.setTitle("점수주기", for: .normal)
        SendAuthenticationCodeButton.setTitleColor(UIColor.white, for: .normal)
        //SendAuthenticationCodeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        //SendAuthenticationCodeButton.titleLabel?.font = UIFont(name: "KoPubWorldDotumBold", size: 16)
        SendAuthenticationCodeButton.titleLabel?.adjustsFontForContentSizeCategory = true
        SendAuthenticationCodeButton.layer.cornerRadius = 4
        SendAuthenticationCodeButton.backgroundColor = UIColor(red: 62/255, green: 202/255, blue: 192/255, alpha: 1.0)
        SendAuthenticationCodeButton.addTarget(self, action: #selector(self.SendAuthenticationCodeButtonTapped), for: .touchUpInside)
        bottomSheetView.addSubview(SendAuthenticationCodeButton)

        SendAuthenticationCodeButton.snp.makeConstraints { (make) in
            make.leading.equalTo(28)
            make.trailing.equalTo(-28)
            make.height.equalTo(41)
            make.top.equalTo(blueBox3.snp.bottom).offset(24)
        }
        
        let attributedString2 = NSAttributedString(
            string: "점수주기",
            attributes: [
                .kern: 1.0,
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "KoPubWorldDotumBold", size: 16)!
            ]
        )
        SendAuthenticationCodeButton.setAttributedTitle(attributedString2, for: .normal)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load7"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMyScore(_:)), name: NSNotification.Name("didUpdateScore"), object: nil)
        
        
        let url = NetworkProtocol.CONTENT_SCORE_REQ
        
        let headers: HTTPHeaders = [
            "X-Device-Id": DeviceIdManager.shared.deviceId
        ]
        
        let parameters: Parameters = [
            "contentMId": data5.contentMID as Any
        ]
        print("parameters:", parameters)
        
        AF.request(url, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: headers).responseJSON { response in
            print(response)
            
            if response.value != nil {
                let jsondata = JSON(response.value!)
                print("jsondata:", jsondata)
                print("1:", jsondata["RESN"])
                print("2:", jsondata["RSLT"])
                print("3:", jsondata["DATA"]["aiScore"])
                print("3:", jsondata["DATA"]["avgUser"])
                print("3:", jsondata["DATA"]["avgTotal"])
                
                
                //self.AIScoreLabel.text = "\(jsondata["DATA"]["aiScore"])점"
                if jsondata["DATA"]["aiScore"].type == .null {
                    self.AIScoreLabel.text = "0점"
                } else {
                    let aiScore = jsondata["DATA"]["aiScore"].doubleValue
                    //self.AIScoreLabel.text = String(format: "%.1f점", aiScore)
                    if floor(aiScore) == aiScore {
                        self.AIScoreLabel.text = String(format: "%.0f점", aiScore)
                    } else {
                        self.AIScoreLabel.text = String(format: "%.1f점", aiScore)
                    }
                }
                if"\(jsondata["DATA"]["aiScore"])" == "null" {
                    self.AIScoreLabel.text = "0점"
                }
                let attributedString = NSMutableAttributedString(string: self.AIScoreLabel.text!)
                attributedString.addAttribute(
                    .kern,
                    //value: 1.0, // 자간
                    value: 0, // 자간
                    range: NSRange(location: 0, length: attributedString.length)
                )
                attributedString.addAttribute(
                    .font,
                    value: UIFont(name: "KoPubWorldDotumBold", size: 20)!,
                    range: NSRange(location: 0, length: attributedString.length)
                )
                
                if attributedString.length >= 2 {
                    attributedString.addAttribute(
                        .kern,
                        value: 5,
                        range: NSRange(location: attributedString.length - 2, length: 1)
                    )
                }
                self.AIScoreLabel.attributedText = attributedString
                
                
                /*let fullText = self.AIScoreLabel.text ?? ""
                let attributedString = NSMutableAttributedString(string: fullText)
                attributedString.addAttribute(
                    .font,
                    value: UIFont(name: "KoPubWorldDotumBold", size: 20)!,
                    range: NSRange(location: 0, length: attributedString.length)
                )
                attributedString.addAttribute(
                    .kern,
                    value: 0,
                    range: NSRange(location: 0, length: attributedString.length)
                )
                if fullText.hasPrefix("1") && fullText.count >= 3 {
                    attributedString.addAttribute(
                        .kern,
                        value: -2.5,
                        range: NSRange(location: 0, length: 1)
                    )
                    
                    if attributedString.length > 2 {
                        attributedString.addAttribute(
                            .kern,
                            value: -0.5,
                            range: NSRange(location: 1, length: attributedString.length - 2)
                        )
                    }
                } else {
                    if attributedString.length > 1 {
                        attributedString.addAttribute(
                            .kern,
                            value: -0.8,
                            range: NSRange(location: 0, length: attributedString.length - 1)
                        )
                    }
                }
                if attributedString.length >= 2 {
                    attributedString.addAttribute(
                        .kern,
                        value: 5,
                        range: NSRange(location: attributedString.length - 2, length: 1)
                    )
                }

                self.AIScoreLabel.attributedText = attributedString*/
                
                
                
                
                
                
                //self.JudgeScoreLabel.text = "\(jsondata["DATA"]["avgUser"])점"
                if jsondata["DATA"]["avgUser"].type == .null {
                    self.JudgeScoreLabel.text = "0점"
                } else {
                    let aiScore = jsondata["DATA"]["avgUser"].doubleValue
                    //self.JudgeScoreLabel.text = String(format: "%.1f점", aiScore)
                    if floor(aiScore) == aiScore {
                        self.JudgeScoreLabel.text = String(format: "%.0f점", aiScore)
                    } else {
                        self.JudgeScoreLabel.text = String(format: "%.1f점", aiScore)
                    }
                }
                if"\(jsondata["DATA"]["avgUser"])" == "null" {
                    self.JudgeScoreLabel.text = "0점"
                }
                let attributedString2 = NSMutableAttributedString(string: self.JudgeScoreLabel.text!)
                attributedString2.addAttribute(
                    .kern,
                    //value: 1.0, // 자간
                    value: 0, // 자간
                    range: NSRange(location: 0, length: attributedString2.length)
                )
                attributedString2.addAttribute(
                    .font,
                    value: UIFont(name: "KoPubWorldDotumBold", size: 20)!,
                    range: NSRange(location: 0, length: attributedString2.length)
                )
                if attributedString2.length >= 2 {
                    attributedString2.addAttribute(
                        .kern,
                        value: 5,
                        range: NSRange(location: attributedString2.length - 2, length: 1)
                    )
                }
                self.JudgeScoreLabel.attributedText = attributedString2
                
                
                
                
                //self.AverageScoreLabel.text = "\(jsondata["DATA"]["avgTotal"])점"
                if jsondata["DATA"]["avgTotal"].type == .null {
                    self.AverageScoreLabel.text = "0점"
                } else {
                    let aiScore = jsondata["DATA"]["avgTotal"].doubleValue
                    //self.AverageScoreLabel.text = String(format: "%.1f점", aiScore)
                    if floor(aiScore) == aiScore {
                        self.AverageScoreLabel.text = String(format: "%.0f점", aiScore)
                    } else {
                        self.AverageScoreLabel.text = String(format: "%.1f점", aiScore)
                    }
                }
                if"\(jsondata["DATA"]["avgTotal"])" == "null" {
                    self.AverageScoreLabel.text = "0점"
                }
                let attributedString3 = NSMutableAttributedString(string: self.AverageScoreLabel.text!)
                attributedString3.addAttribute(
                    .kern,
                    //value: 1.0, // 자간
                    value: 0, // 자간
                    range: NSRange(location: 0, length: attributedString3.length)
                )
                attributedString3.addAttribute(
                    .font,
                    value: UIFont(name: "KoPubWorldDotumBold", size: 20)!,
                    range: NSRange(location: 0, length: attributedString3.length)
                )
                if attributedString3.length >= 2 {
                    attributedString3.addAttribute(
                        .kern,
                        value: 5,
                        range: NSRange(location: attributedString3.length - 2, length: 1)
                    )
                }
                self.AverageScoreLabel.attributedText = attributedString3
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Grading3ViewController의 view가 Load됨")
        
        self.load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Grading3ViewController의 view가 화면에 나타남")
        
        showBottomSheet()
        
        blueBox.layer.addBorder([.bottom], color: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).withAlphaComponent(0.5), width: 1)
        blueBox2.layer.addBorder([.bottom], color: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).withAlphaComponent(0.5), width: 1)
        blueBox3.layer.addBorder([.bottom], color: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).withAlphaComponent(0.5), width: 1)
    }
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        print("grading close button tapped")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Grading3ViewController의 view가 사라지기 전")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Grading3ViewController의 view가 사라짐")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("Grading3ViewController의 SubView를 레이아웃 하려함")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Grading3ViewController의 SubView를 레이아웃 함")
    }
    
    private func setupUI() {
        view.addSubview(dimmedView)
        view.addSubview(bottomSheetView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        /*let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)*/
        
        /*NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint,
        ])*/
        
        dimmedView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints { (make) in
            make.width.equalTo(345)
            make.height.equalTo(294)
            make.leading.equalTo(14)
            make.trailing.equalTo(-14)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
    }
    
    private func showBottomSheet() {
        /*let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight*/
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.7
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
     }
    
    @objc func SendAuthenticationCodeButtonTapped(_ sender: UIButton) {
        /*let vc = BottomSheet3ViewController()
        //let vc = AlreadyRegisteredScoreViewController()
        vc.modalPresentationStyle = .custom
        //vc.modalPresentationStyle = .fullScreen
        vc.data6 = data5
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)*/
        
        
        let x1: Int? = data5.myScore
        let b1 = x1.map(String.init) ?? ""
        
        if b1 == "null" || b1 == "" {
            //let vc = BottomSheet3ViewController()
            let vc = FoldableBottomSheet3ViewController()
            //vc.modalPresentationStyle = .custom
            //vc.modalPresentationStyle = .fullScreen
            vc.modalPresentationStyle = .overFullScreen
            vc.data6 = data5
            vc.transitioningDelegate = self
            self.present(vc, animated: true, completion: nil)
            
        } else {
            //let vc = BottomSheet3ViewController()
            //let vc = AlreadyRegisteredScoreViewController()
            let vc = FoldableAlreadyRegisteredScoreViewController()
            //vc.modalPresentationStyle = .custom
            //vc.modalPresentationStyle = .fullScreen
            vc.modalPresentationStyle = .overFullScreen
            vc.data6 = data5
            //vc.myScore = data5.myScore
            vc.transitioningDelegate = self
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
            
            
            /*let url = NetworkProtocol.CONTENT_SCORE_REQ
            
            /*let headers: HTTPHeaders = [
            ]*/
            
            let parameters: Parameters = [
                "contentMId": data5.contentMID as Any
            ]
            print("parameters:", parameters)
            
            AF.request(url, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON { response in
                print(response)
                
                if response.value != nil {
                    let jsondata = JSON(response.value!)
                    print("jsondata:", jsondata)
                    print("1:", jsondata["RESN"])
                    print("2:", jsondata["RSLT"])
                    print("3:", jsondata["DATA"]["aiScore"])
                    print("3:", jsondata["DATA"]["avgUser"])
                    print("3:", jsondata["DATA"]["avgTotal"])
                    
                    
                    let vc = AlreadyRegisteredScoreViewController()
                    vc.modalPresentationStyle = .custom
                    //vc.modalPresentationStyle = .fullScreen
                    vc.noreceivedValueFromBeforeVC = "\(jsondata["DATA"]["avgUser"])"
                    //vc.myScore = data5.myScore
                    vc.data6 = self.data5
                    vc.transitioningDelegate = self
                    self.present(vc, animated: true, completion: nil)
                }
            }*/
        }
    }
    
    @objc func loadList(notification: NSNotification){
        self.load()
    }
    
    func load() {
        let url = NetworkProtocol.CONTENT_SCORE_REQ
        
        let headers: HTTPHeaders = [
            "X-Device-Id": DeviceIdManager.shared.deviceId
        ]
        
        let parameters: Parameters = [
            "contentMId": data5.contentMID as Any
        ]
        print("parameters:", parameters)
        
        AF.request(url, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: headers).responseJSON { response in
            print(response)
            
            if response.value != nil {
                let jsondata = JSON(response.value!)
                print("load jsondata:", jsondata)
                print("load 1:", jsondata["RESN"])
                print("load 2:", jsondata["RSLT"])
                print("load 3:", jsondata["DATA"]["aiScore"])
                print("load 3:", jsondata["DATA"]["avgUser"])
                print("load 3:", jsondata["DATA"]["avgTotal"])
                
                
                //self.AIScoreLabel.text = "\(jsondata["DATA"]["aiScore"])점"
                if jsondata["DATA"]["aiScore"].type == .null {
                    self.AIScoreLabel.text = "0점"
                } else {
                    let aiScore = jsondata["DATA"]["aiScore"].doubleValue
                    //self.AIScoreLabel.text = String(format: "%.1f점", aiScore)
                    if floor(aiScore) == aiScore {
                        self.AIScoreLabel.text = String(format: "%.0f점", aiScore)
                    } else {
                        self.AverageScoreLabel.text = String(format: "%.1f점", aiScore)
                    }
                }
                if"\(jsondata["DATA"]["aiScore"])" == "null" {
                    self.AIScoreLabel.text = "0점"
                }
                let attributedString = NSMutableAttributedString(string: self.AIScoreLabel.text!)
                attributedString.addAttribute(
                    .kern,
                    //value: 1.0, // 자간
                    value: 0, // 자간
                    range: NSRange(location: 0, length: attributedString.length)
                )
                attributedString.addAttribute(
                    .font,
                    value: UIFont(name: "KoPubWorldDotumBold", size: 20)!,
                    range: NSRange(location: 0, length: attributedString.length)
                )
                if attributedString.length >= 2 {
                    attributedString.addAttribute(
                        .kern,
                        value: 5,
                        range: NSRange(location: attributedString.length - 2, length: 1)
                    )
                }
                self.AIScoreLabel.attributedText = attributedString
                
                
                /*let fullText = self.AIScoreLabel.text ?? ""
                let attributedString = NSMutableAttributedString(string: fullText)
                attributedString.addAttribute(
                    .font,
                    value: UIFont(name: "KoPubWorldDotumBold", size: 20)!,
                    range: NSRange(location: 0, length: attributedString.length)
                )
                attributedString.addAttribute(
                    .kern,
                    value: 0,
                    range: NSRange(location: 0, length: attributedString.length)
                )
                if fullText.hasPrefix("1") && fullText.count >= 3 {
                    attributedString.addAttribute(
                        .kern,
                        value: -2.5,
                        range: NSRange(location: 0, length: 1)
                    )
                    if attributedString.length > 2 {
                        attributedString.addAttribute(
                            .kern,
                            value: -0.5,
                            range: NSRange(location: 1, length: attributedString.length - 2)
                        )
                    }
                } else {
                    if attributedString.length > 1 {
                        attributedString.addAttribute(
                            .kern,
                            value: -0.8,
                            range: NSRange(location: 0, length: attributedString.length - 1)
                        )
                    }
                }
                if attributedString.length >= 2 {
                    attributedString.addAttribute(
                        .kern,
                        value: 5,
                        range: NSRange(location: attributedString.length - 2, length: 1)
                    )
                }

                self.AIScoreLabel.attributedText = attributedString*/
                
                
                
                
                
                //self.JudgeScoreLabel.text = "\(jsondata["DATA"]["avgUser"])점"
                if jsondata["DATA"]["avgUser"].type == .null {
                    self.JudgeScoreLabel.text = "0점"
                }
                else {
                    let aiScore = jsondata["DATA"]["avgUser"].doubleValue
                    //self.JudgeScoreLabel.text = String(format: "%.1f점", aiScore)
                    if floor(aiScore) == aiScore {
                        self.JudgeScoreLabel.text = String(format: "%.0f점", aiScore)
                    } else {
                        self.JudgeScoreLabel.text = String(format: "%.1f점", aiScore)
                    }
                }
                if"\(jsondata["DATA"]["avgUser"])" == "null" {
                    self.JudgeScoreLabel.text = "0점"
                }
                let attributedString2 = NSMutableAttributedString(string: self.JudgeScoreLabel.text!)
                attributedString2.addAttribute(
                    .kern,
                    //value: 1.0, // 자간
                    value: 0, // 자간
                    range: NSRange(location: 0, length: attributedString2.length)
                )
                attributedString2.addAttribute(
                    .font,
                    value: UIFont(name: "KoPubWorldDotumBold", size: 20)!,
                    range: NSRange(location: 0, length: attributedString2.length)
                )
                if attributedString2.length >= 2 {
                    attributedString2.addAttribute(
                        .kern,
                        value: 5,
                        range: NSRange(location: attributedString2.length - 2, length: 1)
                    )
                }
                self.JudgeScoreLabel.attributedText = attributedString2
                
                
                
                //self.AverageScoreLabel.text = "\(jsondata["DATA"]["avgTotal"])점"
                if jsondata["DATA"]["avgTotal"].type == .null {
                    self.AverageScoreLabel.text = "0점"
                }
                else {
                    let aiScore = jsondata["DATA"]["avgTotal"].doubleValue
                    //self.AverageScoreLabel.text = String(format: "%.1f점", aiScore)
                    if floor(aiScore) == aiScore {
                        self.AverageScoreLabel.text = String(format: "%.0f점", aiScore)
                    } else {
                        self.AverageScoreLabel.text = String(format: "%.1f점", aiScore)
                    }
                }
                if"\(jsondata["DATA"]["avgTotal"])" == "null" {
                    self.AverageScoreLabel.text = "0점"
                }
                let attributedString3 = NSMutableAttributedString(string: self.AverageScoreLabel.text!)
                attributedString3.addAttribute(
                    .kern,
                    //value: 1.0, // 자간
                    value: 0, // 자간
                    range: NSRange(location: 0, length: attributedString3.length)
                )
                attributedString3.addAttribute(
                    .font,
                    value: UIFont(name: "KoPubWorldDotumBold", size: 20)!,
                    range: NSRange(location: 0, length: attributedString3.length)
                )
                if attributedString3.length >= 2 {
                    attributedString3.addAttribute(
                        .kern,
                        value: 5,
                        range: NSRange(location: attributedString3.length - 2, length: 1)
                    )
                }
                self.AverageScoreLabel.attributedText = attributedString3
            }
        }
    }
    
    //Grading3ViewController => AlreadyRegisteredScoreViewController => AlreadyRegisteredScoreBottomSheetViewController
    func didUpdateScore(_ score: Int) {
        self.data5.myScore = score
        //updateScoreLabel(score)
        print("Grading3ViewController => AlreadyRegisteredScoreViewController => AlreadyRegisteredScoreBottomSheetViewController", score)
    }
    
    //Grading3ViewController => BottomSheet3ViewController
    @objc func updateMyScore(_ notification: Notification) {
        if let score = notification.userInfo?["score"] as? Int {
            self.data5.myScore = score
            print("Grading3ViewController => BottomSheet3ViewController score", score)
        }
    }
}

extension Grading3ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
        
        /*if presented is AlreadyRegisteredScoreViewController {
            return GradingPresentationController(presentedViewController: presented, presenting: presenting)
        }
        return PresentationController(presentedViewController: presented, presenting: presenting)*/
    }
}
