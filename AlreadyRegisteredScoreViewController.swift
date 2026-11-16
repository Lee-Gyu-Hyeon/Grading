import UIKit

protocol AlreadyRegisteredScoreViewControllerDelegate: AnyObject {
    func didUpdateScore(_ score: Int)
}

class AlreadyRegisteredScoreViewController: UIViewController, UITextFieldDelegate, AlreadyRegisteredScoreBottomSheetViewControllerDelegate {
    
    let token = UserDefaults.standard.string(forKey: "loginID") ?? "" //이메일
    let token2 = UserDefaults.standard.string(forKey: "session") ?? "" //로그인 세션
    
    let dimmedView = UIView()
    let bottomSheetView = UIView()
    
    let closeButton = UIButton()
    
    let AIScoreLabel = UILabel()
    let AIScore2Label = UILabel()
    
    let ScoringEditTextField = UITextField()
    let ScoreLabel = UILabel()
    let view4 = UIView()
    
    let maintainButton = UIButton()
    let GivemyscoreButton = UIButton()
    let horizontalStackView = UIStackView()
    
    let AIScore3Label = UILabel()
    
    let newTF = UITextField()
    
    let viewAcc = UIView()
    let btnDone = UIButton()
    
    //var myScore: Int?
    var data6: ListContentM!
    //var noreceivedValueFromBeforeVC = ""
    weak var delegate: AlreadyRegisteredScoreViewControllerDelegate?
    

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
            make.trailing.equalTo(-21)
            make.width.height.equalTo(14)
            make.top.equalTo(12)
        }
        
        
        AIScoreLabel.text = "이미 점수를 주셨어요 !"
        //AIScoreLabel.font = UIFont.boldSystemFont(ofSize: 18)
        AIScoreLabel.textColor = UIColor(red: 62/255, green: 202/255, blue: 192/255, alpha: 1.0)
        AIScoreLabel.font = UIFont(name: "KoPubWorldDotumBold", size: 25)
        AIScoreLabel.adjustsFontSizeToFitWidth = true
        bottomSheetView.addSubview(AIScoreLabel)
        
        AIScoreLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(33)
        }
        
        
        AIScore2Label.text = "내가 준 점수"
        //AIScore2Label.font = UIFont.boldSystemFont(ofSize: 18)
        AIScore2Label.textColor = UIColor.black
        AIScore2Label.font = UIFont(name: "KoPubWorldDotumMedium", size: 25)
        AIScore2Label.adjustsFontSizeToFitWidth = true
        bottomSheetView.addSubview(AIScore2Label)
        
        AIScore2Label.snp.makeConstraints { (make) in
            make.leading.equalTo(52)
            make.top.equalTo(AIScoreLabel.snp.bottom).offset(27)
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
        
        ScoringEditTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 46, height: 0))
        ScoringEditTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 46, height: 0))
        
        //ScoringEditTextField.font = UIFont.systemFont(ofSize: 20)
        //ScoringEditTextField.font = UIFont(name: "KoPubWorldDotumBold", size: 27)
        ScoringEditTextField.adjustsFontSizeToFitWidth = false
        //ScoringEditTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        ScoringEditTextField.leftViewMode = .always
        //ScoringEditTextField.layer.borderWidth = 1.0
        ScoringEditTextField.keyboardType = .numberPad
        ScoringEditTextField.setBottomBorder()
        ScoringEditTextField.delegate = self
        ScoringEditTextField.isUserInteractionEnabled = false
        bottomSheetView.addSubview(ScoringEditTextField)
        
        ScoringEditTextField.snp.makeConstraints{ (make) in
            make.width.equalTo(107)
            make.leading.equalTo(AIScore2Label.snp.trailing).offset(10)
            make.top.equalTo(AIScoreLabel.snp.bottom).offset(25)
        }
        
        let x1: Int? = data6.myScore
        let b1 = x1.map(String.init) ?? ""
        print(">>>>>> AlreadyRegisteredScoreViewController myScore", b1)
        
        let attributedString = NSMutableAttributedString(string: b1)
        attributedString.addAttribute(
            .kern,
            //value: 2.7, //글자 자간
            value: 0, //글자 자간
            range: NSRange(location: 0, length: attributedString.length)
        )
        attributedString.addAttribute(
            .font,
            value: UIFont(name: "KoPubWorldDotumBold", size: 27)!,
            range: NSRange(location: 0, length: attributedString.length)
        )
        ScoringEditTextField.attributedText = attributedString
        adjustLeftViewForText(b1)
        
        
        
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
            make.centerY.equalTo(ScoringEditTextField.snp.centerY).offset(-1)
        }
        
        
        //maintainButton.setTitle("유지하기", for: .normal)
        maintainButton.backgroundColor = UIColor(red: 62/255, green: 202/255, blue: 192/255, alpha: 1.0)
        //maintainButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        //maintainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        //maintainButton.titleLabel?.font = UIFont(name: "KoPubWorldDotumBold", size: 16)
        maintainButton.titleLabel?.adjustsFontForContentSizeCategory = true
        maintainButton.setTitleColor(UIColor.white, for: .normal)
        //maintainButton.layer.borderWidth = 1
        //maintainButton.layer.borderColor = UIColor(red: 62/255, green: 202/255, blue: 192/255, alpha: 1.0).cgColor
        maintainButton.addTarget(self, action: #selector(maintainButtonButtonTapped), for: .touchUpInside)
        maintainButton.layer.cornerRadius = 4
        horizontalStackView.addArrangedSubview(maintainButton)
        
        maintainButton.snp.makeConstraints{ (make) in
        }
        
        let attributedString2 = NSAttributedString(
            string: "유지하기",
            attributes: [
                .kern: 1.0,
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "KoPubWorldDotumBold", size: 16)!
            ]
        )
        maintainButton.setAttributedTitle(attributedString2, for: .normal)
        
        
        
        //GivemyscoreButton.setTitle("내 점수주기", for: .normal)
        //GivemyscoreButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        //GivemyscoreButton.titleLabel?.font = UIFont(name: "KoPubWorldDotumBold", size: 18)
        GivemyscoreButton.titleLabel?.adjustsFontForContentSizeCategory = true
        GivemyscoreButton.addTarget(self, action: #selector(GivemyscoreButtonTapped), for: .touchUpInside)
        GivemyscoreButton.titleLabel?.textColor = UIColor.white
        //UploadButton.backgroundColor = UIColor.gray
        //UploadButton.isEnabled = false
        GivemyscoreButton.backgroundColor = UIColor(red: 62/255, green: 202/255, blue: 192/255, alpha: 1.0)
        GivemyscoreButton.layer.cornerRadius = 4
        horizontalStackView.addArrangedSubview(GivemyscoreButton)
        
        GivemyscoreButton.snp.makeConstraints { (make) in
        }
        
        let attributedString3 = NSAttributedString(
            string: "내 점수주기",
            attributes: [
                .kern: 1.0,
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "KoPubWorldDotumBold", size: 16)!
            ]
        )
        GivemyscoreButton.setAttributedTitle(attributedString3, for: .normal)
        
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 12
        bottomSheetView.addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints { (make) in
            make.top.equalTo(AIScore2Label.snp.bottom).offset(38)
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
            make.height.equalTo(39)
        }
        
        
        AIScore3Label.text = "점수를 수정하시면 기존 점수 기록은 삭제됩니다."
        //AIScore3Label.font = UIFont.boldSystemFont(ofSize: 18)
        AIScore3Label.textColor = UIColor.black
        AIScore3Label.font = UIFont(name: "KoPubWorldDotumMedium", size: 14)
        AIScore3Label.adjustsFontSizeToFitWidth = true
        bottomSheetView.addSubview(AIScore3Label)
        
        AIScore3Label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(horizontalStackView.snp.bottom).offset(6)
        }
        
        if let text = AIScore3Label.text {
            let range = (text as NSString).range(of: "기존 점수 기록은 삭제")
            myLabelChangeColor(text, range: range)
        }
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func maintainButtonButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func GivemyscoreButtonTapped(_ sender: UIButton) {
        /*let vc = BottomSheet3ViewController()
        //let vc = AlreadyRegisteredScoreViewController()
        vc.modalPresentationStyle = .custom
        //vc.modalPresentationStyle = .fullScreen
        vc.data6 = data6
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)*/
        
        
        guard let grading3VC = self.presentingViewController as? Grading3ViewController else { return }
        
        //let vc = AlreadyRegisteredScoreBottomSheetViewController()
        let vc = FoldableAlreadyRegisteredScoreBottomSheetViewController()
        //vc.modalPresentationStyle = .custom
        //vc.modalPresentationStyle = .fullScreen
        vc.modalPresentationStyle = .overFullScreen
        vc.data6 = data6
        vc.transitioningDelegate = self
        vc.delegate = self
        //self.present(vc, animated: true, completion: nil)
        
        self.dismiss(animated: false) {
            grading3VC.present(vc, animated: true, completion: nil)
        }
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
        btnDone.setTitle("작성", for: .normal)
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
            make.width.equalTo(47)
            make.height.equalTo(28)
            make.top.equalTo(10)
            make.right.equalToSuperview().inset(10)
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
            make.height.equalTo(256)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
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
        
        if updateText.count == 0 {
            return true
        }
        
        if newText.isEmpty {
            adjustLeftViewForText("")
            return true
        }
        
        // 숫자만 허용하고 3자리 이하로 제한
        if newText.count <= 3 && newText.allSatisfy({ $0.isNumber }) {
            // leftView 조정
            adjustLeftViewForText(newText)
        }
        
        if let score = Int(updateText), score >= 0, score <= 100 {
            return true
            
        } else {
            //let alert = UIAlertController(title: "Invalid Score", message: "Score must be a number from 0 to 100", preferredStyle: .alert)
            let alert = UIAlertController(title: "알림", message: "점수는 0점부터 100점까지 입력 가능합니다.", preferredStyle: .alert)
            
            //alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
                self.newTF.text = nil
            }))
            
            self.present(alert, animated: true, completion: nil)
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
        /*case 4:
            leftViewWidth = 5  //소수점*/
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
            //sender.text = "" //TextField공백처리
            
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
                self.dismiss(animated: true)
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
    
    func didUpdateScore(_ score: Int) {
        print("BottomSheet로부터 받은 점수:", score)
        self.data6.myScore = score
        //updateScoreUI(score)
        delegate?.didUpdateScore(score)
    }
    
    func myLabelChangeColor(_ text:String, range :NSRange){
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 62/255, green: 202/255, blue: 192/255, alpha: 1.0), range: range)
        AIScore3Label.attributedText = attributedString
    }
}

extension AlreadyRegisteredScoreViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
