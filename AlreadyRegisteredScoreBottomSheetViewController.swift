import UIKit
import Alamofire
import SwiftyJSON
import CryptoSwift

protocol AlreadyRegisteredScoreBottomSheetViewControllerDelegate: AnyObject {
    func didUpdateScore(_ score: Int)
}

class AlreadyRegisteredScoreBottomSheetViewController: UIViewController, UITextFieldDelegate {
    
    let token = UserDefaults.standard.string(forKey: "loginID") ?? "" //이메일
    let token2 = UserDefaults.standard.string(forKey: "session") ?? "" //로그인 세션

    let dimmedView = UIView()
    let bottomSheetView = UIView()
    
    let closeButton = UIButton()
    let AIScoreLabel = UILabel()
    let ScoringEditTextField = UITextField()
    let ScoreLabel = UILabel()
    let view4 = UIView()
    
    let messageLabel = UILabel()
    
    let newTF = UITextField()
    let viewAcc = UIView()
    let btnDone = UIButton()
    
    let SendAuthenticationCodeButton = UIButton()
    var myScore: Int?
    
    var data6: ListContentM!
    weak var delegate: AlreadyRegisteredScoreBottomSheetViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        dimmedView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        dimmedView.alpha = 0.0
        
        bottomSheetView.backgroundColor = .white
        bottomSheetView.clipsToBounds = true
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.layer.cornerRadius = 6
        
        
        closeButton.setImage(UIImage(named: "img_btn_givescore_close"), for: .normal)
        closeButton.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
        bottomSheetView.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(-15)
            make.width.height.equalTo(14)
            make.top.equalTo(10)
        }
        
        
        AIScoreLabel.text = "심사위원 점수"
        //AIScoreLabel.font = UIFont.boldSystemFont(ofSize: 18)
        AIScoreLabel.font = UIFont(name: "KoPubWorldDotumBold", size: 20)
        AIScoreLabel.adjustsFontSizeToFitWidth = true
        bottomSheetView.addSubview(AIScoreLabel)
        
        AIScoreLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(19)
        }
        
        
        ScoringEditTextField.backgroundColor = UIColor.white
        //ScoringEditTextField.layer.borderColor = UIColor(red: 147/255, green: 178/255, blue: 195/255, alpha: 1.0).cgColor
        ScoringEditTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        ScoringEditTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1.0)])
        /*let UserNameTextFieldplaceHolder = NSAttributedString(string: "이름 or 별명을 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 137/255, green: 137/255, blue: 137/255, alpha: 1.0)])
        UserBirthdayChoiceTextField.attributedPlaceholder = UserNameTextFieldplaceHolder*/

        ScoringEditTextField.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1.0)
        //ScoringEditTextField.layer.cornerRadius = 2.0
        //ScoringEditTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 0))
        //ScoringEditTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 0))
        
        //ScoringEditTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0)) //3자리
        //ScoringEditTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 31, height: 0)) //2자리
        //ScoringEditTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 46, height: 0)) //1자리
        
        ScoringEditTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 0))
        ScoringEditTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 0))
        
        //ScoringEditTextField.font = UIFont.systemFont(ofSize: 20)
        //ScoringEditTextField.font = UIFont(name: "KoPubWorldDotumBold", size: 27)
        ScoringEditTextField.adjustsFontSizeToFitWidth = false
        //ScoringEditTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        ScoringEditTextField.leftViewMode = .always
        //ScoringEditTextField.layer.borderWidth = 1.0
        ScoringEditTextField.keyboardType = .numberPad
        ScoringEditTextField.setBottomBorder()
        ScoringEditTextField.delegate = self
        bottomSheetView.addSubview(ScoringEditTextField)
        
        ScoringEditTextField.snp.makeConstraints{ (make) in
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
            make.top.equalTo(AIScoreLabel.snp.bottom).offset(16)
        }
        
        let attributedString2 = NSMutableAttributedString(string: " ")
        attributedString2.addAttribute(
            .kern,
            //value: 2.7, //글자 자간
            value: 0, //글자 자간
            range: NSRange(location: 0, length: attributedString2.length)
        )
        attributedString2.addAttribute(
            .font,
            value: UIFont(name: "KoPubWorldDotumBold", size: 27)!,
            range: NSRange(location: 0, length: attributedString2.length)
        )
        ScoringEditTextField.attributedText = attributedString2
        
        
        
        
        
        ScoreLabel.text = "점"
        //ScoreLabel.font = UIFont.boldSystemFont(ofSize: 23)
        ScoreLabel.font = UIFont(name: "KoPubWorldDotumMedium", size: 27)
        ScoreLabel.adjustsFontSizeToFitWidth = true
        ScoreLabel.textColor = UIColor.black
        view4.addSubview(ScoreLabel)
        
        ScoreLabel.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
        view4.backgroundColor = UIColor.clear
        //ScoringEditTextField.rightViewMode = UITextField.ViewMode.always
        ScoringEditTextField.rightViewMode = .never
        //ScoringEditTextField.rightView = view4
        //view4.transform = CGAffineTransform(translationX: 0, y: 0)
        //ScoringEditTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        ScoringEditTextField.addSubview(view4)
        bottomSheetView.addSubview(view4)
        
        /*view4.snp.makeConstraints{ (make) in
            make.width.equalTo(24)
            make.height.equalTo(40)
        }*/
        view4.snp.makeConstraints { (make) in
            make.width.equalTo(24)
            make.height.equalTo(41)
            make.trailing.equalTo(ScoringEditTextField.snp.trailing).offset(-9) // ScoringEditTextField의 오른쪽에서 -9만큼
            make.centerY.equalTo(ScoringEditTextField.snp.centerY) // 수직 중앙 정렬
        }
        
        
        
        messageLabel.text = "점수는 0부터 100까지, 1점 단위로 주실 수 있어요!"
        //ScoreLabel.font = UIFont.boldSystemFont(ofSize: 23)
        messageLabel.font = UIFont(name: "KoPubWorldDotumMedium", size: 14)
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.textColor = UIColor.black
        messageLabel.isHidden = true
        bottomSheetView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(ScoringEditTextField.snp.bottom).offset(19)
        }
        
        if let text = messageLabel.text {
            let attributedString = NSMutableAttributedString(string: text)
            let color = UIColor(red: 62/255, green: 202/255, blue: 192/255, alpha: 1.0)
            
            let range0 = (text as NSString).range(of: "0")
            if range0.location != NSNotFound {
                attributedString.addAttribute(.foregroundColor, value: color, range: range0)
            }
            
            let range100 = (text as NSString).range(of: "100")
            if range100.location != NSNotFound {
                attributedString.addAttribute(.foregroundColor, value: color, range: range100)
            }

            messageLabel.attributedText = attributedString
        }
        
        
        
        
        
        //SendAuthenticationCodeButton.setTitle("채점하기", for: .normal)
        SendAuthenticationCodeButton.setTitleColor(UIColor.white, for: .normal)
        //SendAuthenticationCodeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        //SendAuthenticationCodeButton.titleLabel?.font = UIFont(name: "KoPubWorldDotumMedium", size: 16)
        SendAuthenticationCodeButton.layer.cornerRadius = 4
        SendAuthenticationCodeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        SendAuthenticationCodeButton.backgroundColor = UIColor(red: 62/255, green: 202/255, blue: 192/255, alpha: 1.0)
        SendAuthenticationCodeButton.addTarget(self, action: #selector(self.SendAuthenticationCodeButtonTapped), for: .touchUpInside)
        bottomSheetView.addSubview(SendAuthenticationCodeButton)

        SendAuthenticationCodeButton.snp.makeConstraints { (make) in
            make.leading.equalTo(28)
            make.trailing.equalTo(-28)
            make.height.equalTo(39)
            make.top.equalTo(messageLabel.snp.bottom).offset(4)
        }
        
        let attributedString = NSAttributedString(
            string: "점수주기",
            attributes: [
                .kern: 1.0,
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "KoPubWorldDotumBold", size: 16)!
            ]
        )
        SendAuthenticationCodeButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
        makeInputAccessoryView()
    }
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        print("grading close button tapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeInputAccessoryView() {
        viewAcc.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
        viewAcc.backgroundColor = UIColor.gray
        
        newTF.backgroundColor = UIColor.white
        newTF.layer.borderWidth = 1
        newTF.layer.borderColor = UIColor.gray.cgColor
        newTF.font = UIFont.systemFont(ofSize: 15)
        newTF.keyboardType = .numberPad
        newTF.delegate = self
        newTF.textAlignment = .center
        //newTF.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        
        btnDone.backgroundColor = UIColor(red: 62/255, green: 202/255, blue: 192/255, alpha: 1.0)
        btnDone.setTitle("완료", for: .normal)
        btnDone.layer.cornerRadius = 4
        btnDone.addTarget(self, action: #selector(self.commentwriteButtonTapped), for: .touchUpInside)
        //btnDone.semanticContentAttribute = .forceRightToLeft
        btnDone.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        /*btnDone.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        btnDone.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        btnDone.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)*/
        
        viewAcc.addSubview(newTF)
        newTF.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(50)
            make.trailing.equalToSuperview()
        }
        
        
        viewAcc.addSubview(btnDone)
        btnDone.snp.makeConstraints { make in
            /*make.width.equalTo(47)
            make.height.equalTo(28)
            make.top.equalTo(10)
            make.right.equalToSuperview().inset(10)*/
            
            make.width.equalTo(47)
            make.height.equalTo(29)
            make.top.equalTo(9.5)
            make.right.equalToSuperview().inset(9)
        }

        self.ScoringEditTextField.inputAccessoryView = viewAcc
    }
    
    private func setupUI() {
        view.addSubview(dimmedView)
        view.addSubview(bottomSheetView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        dimmedView.snp.makeConstraints {(make) in
            make.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints { (make) in
            make.width.equalTo(345)
            make.height.equalTo(211)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
    }
    
    private func showBottomSheet() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.7
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        ScoringEditTextField.becomeFirstResponder()
        newTF.becomeFirstResponder()
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == newTF {
            ScoringEditTextField.text = newText
        }
        
        if updateText.count == 0 {
            return true
        }
        
        if newText.isEmpty {
            adjustLeftViewForText("")
            return true
        }
        
        if updateText.count > 1 && updateText.first == "0" {
            newTF.text = ""
            ScoringEditTextField.text = ""
            return false
        }
        
        // 숫자만 허용하고 3자리 이하로 제한
        if newText.count <= 3 && newText.allSatisfy({ $0.isNumber }) {
            adjustLeftViewForText(newText) // leftView 조정
        }
        
        if let score = Int(updateText), score >= 0, score <= 100 {
            messageLabel.isHidden = true
            return true
            
        } else {
            //let alert = UIAlertController(title: "Invalid Score", message: "Score must be a number from 0 to 100", preferredStyle: .alert)
            /*let alert = UIAlertController(title: "알림", message: "점수는 0점부터 100점까지 입력 가능합니다.", preferredStyle: .alert)
            
            //alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
                self.newTF.text = nil
                self.ScoringEditTextField.text = ""
            }))
            
            self.present(alert, animated: true, completion: nil)*/
            
            
            /*messageLabel.isHidden = false
            self.newTF.text = nil
            self.ScoringEditTextField.text = ""*/
            
            
            if let score = Int(updateText), score >= 0, score <= 100 {
                adjustLeftViewForText(updateText)
                messageLabel.isHidden = true
            } else {
                let limitedText = String(updateText.prefix(3))
                newTF.text = limitedText
                ScoringEditTextField.text = limitedText
                adjustLeftViewForText(limitedText)
                //messageLabel.isHidden = false
            }
            
            //newTF.text?.removeAll()
            return false
        }
    }
    
    func adjustLeftViewForText(_ text: String) {
        let digitCount = text.count
        var leftViewWidth: CGFloat
        
        switch digitCount {
        case 1:
            leftViewWidth = 46  //1자리
        case 2:
            leftViewWidth = 31  //2자리
        case 3:
            leftViewWidth = 15  //3자리
        default:
            leftViewWidth = 46  //기본값
        }
        
        ScoringEditTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftViewWidth, height: 0))
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == ScoringEditTextField {
            
            // newTF 다시 활성화
            newTF.isEnabled = true
            newTF.becomeFirstResponder()
        }
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        newTF.becomeFirstResponder()
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
    }
    
    @objc func textFieldDidChange(sender: UITextField) {
        if !isVaildText(value: sender.text) {
            //sender.text = ""
            
            let alert = UIAlertController(title: "알림", message: "점수 형식이 올바르지 않습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
                sender.text = ""
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
        }
    }
    
    func isVaildText(value: String?) -> Bool {
        guard let str = value, !str.isEmpty else { return false }
        guard str.count < 4 else { return false }
        guard let num = Int(str) else { return false }
        if str.count > 1 && str.first == "0" {
            return false
        }
        return num <= 100
    }
    
    @objc func commentwriteButtonTapped(_ sender: UIButton) {
        if newTF.text == "" {
            let alert = UIAlertController(title: "알림", message: "점수를 입력하세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
                //self.dismiss(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        if token == "" {
            
            let alert = UIAlertController(title: "로그인이 필요한 서비스 입니다.", message: "로그인 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "예", style: .default) { (action) in
                let vc = EmailLogin3ViewController()
                let nvc = CustomNavigationController(rootViewController: vc)
                
                nvc.modalPresentationStyle = .fullScreen
                
                var array = self.navigationController?.viewControllers
                array?.removeLast()
                array?.append(vc)
                
                self.navigationController?.setViewControllers(array!, animated: true)
                self.present(nvc, animated: true, completion: nil)
                
                
                /*let vc = EmailLogin3ViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)*/
            }
            
            let noAction = UIAlertAction(title: "아니오", style: .default) { (action) in
                
            }
            alert.addAction(okAction)
            alert.addAction(noAction)
            
            present(alert, animated: false, completion: nil)
            
        } else {
            // newTF 값 가져오기
            let inputValue = newTF.text ?? ""
            print("inputValue", inputValue)
            
            // ScoringEditTextField에 값 전달
            ScoringEditTextField.text = inputValue
            
            // newTF 초기화 및 비활성화
            newTF.text = ""
            newTF.isEnabled = false
            
            // 키보드 내리기
            self.view.endEditing(true)
        }
    }
    
    @objc func SendAuthenticationCodeButtonTapped(_ sender: UIButton) {
        /*if ScoringEditTextField.text == " " {
            let alert = UIAlertController(title: "알림", message: "점수를 입력하세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
            }))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            self.bottomSheetView.removeFromSuperview()
            self.dimmedView.removeFromSuperview()
            self.dimmedView.backgroundColor = UIColor.clear
            self.dimmedView.alpha = 0.0
            
            self.ScoringEditTextField.becomeFirstResponder()
            self.newTF.becomeFirstResponder()
            
            let url = NetworkProtocol.CONTENT_SCORE_SET_REQ
            
            let headers: HTTPHeaders = [
                "SESSION": token2
            ]
            print("headers:", headers)
            
            let parameters: Parameters = [
                "contentMId": data6.contentMID,
                "score": ScoringEditTextField.text!
            ]
            print("parameters:", parameters)
            
            AF.request(url, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: headers).responseJSON { response in
                print(response)
                
                if response.value != nil {
                    let jsondata = JSON(response.value!)
                    print("jsondata:", jsondata)
                    print("1:", jsondata["RESN"])
                    print("2:", jsondata["RSLT"])
                    
                    if jsondata["RSLT"] == "S" {
                        
                        /*let alert = UIAlertController(title: "알림", message: "점수가 등록되었습니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
                            
                            //self.view.endEditing(true)
                            //self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
                            
                            self.bottomSheetView.removeFromSuperview()
                            self.dimmedView.removeFromSuperview()
                            self.dimmedView.backgroundColor = UIColor.clear
                            self.dimmedView.alpha = 0.0
                            self.ScoringEditTextField.becomeFirstResponder()
                            self.newTF.becomeFirstResponder()
                            self.dismiss(animated: true, completion: nil)
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load7"), object: nil)
                            
                            if let presentingVC = self.presentingViewController?.presentingViewController {
                                presentingVC.dismiss(animated: true) {
                                }
                            }
                            
                            /*self.dismiss(animated: true) {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load7"), object: nil)
                            }*/
                            
                            let scoreText = self.ScoringEditTextField.text?.replacingOccurrences(of: "", with: "") ?? "0"
                            let score = Int(scoreText) ?? 0
                            self.delegate?.didUpdateScore(score)
                        }))
                        self.present(alert, animated: true, completion: nil)*/
                        
                        
                        self.bottomSheetView.removeFromSuperview()
                        self.dimmedView.removeFromSuperview()
                        self.dimmedView.backgroundColor = UIColor.clear
                        self.dimmedView.alpha = 0.0
                        self.ScoringEditTextField.becomeFirstResponder()
                        self.newTF.becomeFirstResponder()
                        self.dismiss(animated: true, completion: nil)
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load7"), object: nil)
                        
                        if let presentingVC = self.presentingViewController?.presentingViewController {
                            presentingVC.dismiss(animated: true) {
                            }
                        }
                        
                        /*self.dismiss(animated: true) {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load7"), object: nil)
                        }*/
                        
                        let scoreText = self.ScoringEditTextField.text?.replacingOccurrences(of: "", with: "") ?? "0"
                        let score = Int(scoreText) ?? 0
                        //self.delegate?.didUpdateScore(score)
                        
                        self.dismiss(animated: true) {
                            self.delegate?.didUpdateScore(score)
                        }
                    }
                }
            }
        }*/
        
        
        self.view.endEditing(true)
        
        guard let inputText = ScoringEditTextField.text, !inputText.isEmpty else {
            print("입력값이 없습니다.")
            let alert = UIAlertController(title: "알림", message: "점수를 입력하세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // 2. 문자열을 Int(정수)로 변환
        if let score = Int(inputText) {
            if score > 100 {
                messageLabel.isHidden = false
                print("100점 이상입니다. 메시지를 표시합니다.")
            } else {
                messageLabel.isHidden = true
                print("100점 미만입니다.")
                self.bottomSheetView.removeFromSuperview()
                self.dimmedView.removeFromSuperview()
                self.dimmedView.backgroundColor = UIColor.clear
                self.dimmedView.alpha = 0.0
                
                self.ScoringEditTextField.becomeFirstResponder()
                self.newTF.becomeFirstResponder()
                
                let url = NetworkProtocol.CONTENT_SCORE_SET_REQ
                
                let headers: HTTPHeaders = [
                    "SESSION": token2,
                    "X-Device-Id": DeviceIdManager.shared.deviceId
                ]
                print("headers:", headers)
                
                let parameters: Parameters = [
                    "contentMId": data6.contentMID,
                    "score": ScoringEditTextField.text!
                ]
                print("parameters:", parameters)
                
                AF.request(url, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: headers).responseJSON { response in
                    print(response)
                    
                    if response.value != nil {
                        let jsondata = JSON(response.value!)
                        print("jsondata:", jsondata)
                        print("1:", jsondata["RESN"])
                        print("2:", jsondata["RSLT"])
                        
                        if jsondata["RSLT"] == "S" {
                            
                            /*let alert = UIAlertController(title: "알림", message: "점수가 등록되었습니다.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
                                
                                //self.view.endEditing(true)
                                //self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
                                
                                self.bottomSheetView.removeFromSuperview()
                                self.dimmedView.removeFromSuperview()
                                self.dimmedView.backgroundColor = UIColor.clear
                                self.dimmedView.alpha = 0.0
                                self.ScoringEditTextField.becomeFirstResponder()
                                self.newTF.becomeFirstResponder()
                                self.dismiss(animated: true, completion: nil)
                                
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load7"), object: nil)
                                
                                if let presentingVC = self.presentingViewController?.presentingViewController {
                                    presentingVC.dismiss(animated: true) {
                                    }
                                }
                                
                                /*self.dismiss(animated: true) {
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load7"), object: nil)
                                }*/
                                
                                let scoreText = self.ScoringEditTextField.text?.replacingOccurrences(of: "", with: "") ?? "0"
                                let score = Int(scoreText) ?? 0
                                self.delegate?.didUpdateScore(score)
                            }))
                            self.present(alert, animated: true, completion: nil)*/
                            
                            
                            self.bottomSheetView.removeFromSuperview()
                            self.dimmedView.removeFromSuperview()
                            self.dimmedView.backgroundColor = UIColor.clear
                            self.dimmedView.alpha = 0.0
                            self.ScoringEditTextField.becomeFirstResponder()
                            self.newTF.becomeFirstResponder()
                            self.dismiss(animated: true, completion: nil)
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load7"), object: nil)
                            
                            /*if let presentingVC = self.presentingViewController?.presentingViewController {
                                presentingVC.dismiss(animated: true) {
                                }
                            }*/
                            
                            /*self.dismiss(animated: true) {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load7"), object: nil)
                            }*/
                            
                            let scoreText = self.ScoringEditTextField.text?.replacingOccurrences(of: "", with: "") ?? "0"
                            let score = Int(scoreText) ?? 0
                            //self.delegate?.didUpdateScore(score)
                            
                            self.dismiss(animated: true) {
                                self.delegate?.didUpdateScore(score)
                            }
                            
                            
                            /*let scoreText = self.ScoringEditTextField.text?.replacingOccurrences(of: " ", with: "") ?? "0"
                            let score = Int(scoreText) ?? 0

                            if let alreadyRegisteredVC = self.presentingViewController,
                               let grading3VC = alreadyRegisteredVC.presentingViewController as? Grading3ViewController {
                                grading3VC.dismiss(animated: false) {
                                    grading3VC.didUpdateScore(score)
                                }
                            }*/
                            
                            /*let scoreText = self.ScoringEditTextField.text?.replacingOccurrences(of: " ", with: "") ?? "0"
                            let score = Int(scoreText) ?? 0

                            if let alreadyRegisteredVC = self.presentingViewController,
                               let grading3VC = alreadyRegisteredVC.presentingViewController as? Grading3ViewController {
                                alreadyRegisteredVC.view.alpha = 0
                             
                                grading3VC.dismiss(animated: false) {
                                    grading3VC.didUpdateScore(score)
                                }
                            }*/
                        }
                    }
                }
            }
        } else {
            print("숫자가 아닌 값이 입력되었습니다.")
            messageLabel.isHidden = false
        }
        
        
        /*self.bottomSheetView.removeFromSuperview()
        self.dimmedView.removeFromSuperview()
        self.dimmedView.backgroundColor = UIColor.clear
        self.dimmedView.alpha = 0.0
        
        self.ScoringEditTextField.becomeFirstResponder()
        self.newTF.becomeFirstResponder()
        
        let url = NetworkProtocol.CONTENT_SCORE_SET_REQ
        
        let headers: HTTPHeaders = [
            "SESSION": token2
        ]
        print("headers:", headers)
        
        let parameters: Parameters = [
            "contentMId": data6.contentMID,
            "score": ScoringEditTextField.text!
        ]
        print("parameters:", parameters)
        
        AF.request(url, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: headers).responseJSON { response in
            print(response)
            
            if response.value != nil {
                let jsondata = JSON(response.value!)
                print("jsondata:", jsondata)
                print("1:", jsondata["RESN"])
                print("2:", jsondata["RSLT"])
                
                if jsondata["RSLT"] == "S" {
                    
                    let alert = UIAlertController(title: "알림", message: "점수가 등록되었습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
                        
                        //self.view.endEditing(true)
                        //self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
                        
                        self.bottomSheetView.removeFromSuperview()
                        self.dimmedView.removeFromSuperview()
                        self.dimmedView.backgroundColor = UIColor.clear
                        self.dimmedView.alpha = 0.0
                        self.ScoringEditTextField.becomeFirstResponder()
                        self.newTF.becomeFirstResponder()
                        self.dismiss(animated: true, completion: nil)
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load7"), object: nil)
                        
                        if let presentingVC = self.presentingViewController?.presentingViewController {
                            presentingVC.dismiss(animated: true) {
                            }
                        }
                        
                        /*self.dismiss(animated: true) {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load7"), object: nil)
                        }*/
                        
                        let scoreText = self.ScoringEditTextField.text?.replacingOccurrences(of: "", with: "") ?? "0"
                        let score = Int(scoreText) ?? 0
                        self.delegate?.didUpdateScore(score)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }*/
    }
}

extension AlreadyRegisteredScoreBottomSheetViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
