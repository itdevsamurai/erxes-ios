//
//  NoteController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 10/10/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import MessageUI
class NoteController: UIViewController {

    weak var delegate: ContactDelegate?
    var isCompany = Bool()
    var notes = [LogData]() {
        didSet{
            
            for (index, note) in notes.enumerated() {
                
                let filtered = note.list.filter({$0?.action == "internal_note-create"})
                self.notes[index].list = filtered
                
            }
            self.notes = self.notes.filter({$0.list.count != 0})
            tableView.reloadData()
        }
    }
    
    let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
    let textView = UITextView(frame: CGRect.zero)
    var contactId = String()
    var email = String()
    var noteButton: UIButton = {
       let button = UIButton()
        button.setTitle("  New note", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Font.regular(14)
        button.setImage(UIImage.erxes(with: .edit1, textColor: .black, size: CGSize(width: 14, height: 14)), for: .normal)
        button.addTarget(self, action: #selector(noteAction), for: .touchUpInside)
        return button
    }()
    
    @objc func noteAction() {
        alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
        textView.text = "   Start typing to leave a note"
        self.present(alertController, animated: true, completion: nil)
    }


    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue{
                let margin:CGFloat = 8.0
                textView.frame = CGRect(x:rect.origin.x + margin, y:rect.origin.y + margin, width:rect.width - 2*margin, height:rect.height / 2)
                textView.bounds = CGRect(x:rect.origin.x + margin, y:rect.origin.y + margin, width:rect.width - 2*margin, height:rect.height / 2)
            }
        }
    }
    var emailButton: UIButton = {
        let button = UIButton()
        button.setTitle("  Email", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Font.regular(14)
        button.setImage(UIImage.erxes(with: .email, textColor: .black, size: CGSize(width: 14, height: 14)), for: .normal)
        button.addTarget(self, action: #selector(emailAction), for: .touchUpInside)
        return button
    }()
    
    @objc func emailAction() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.navigationController?.navigationBar.tintColor = .ERXES_COLOR
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "No mail accounts", message: "Please set up a Mail account in order to send email", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ActivityCellCon.self, forCellReuseIdentifier: "ActivityCellCon")
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.separatorColor = UIColor.LIGHT_GRAY_COLOR
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(noteButton)
        self.view.addSubview(emailButton)
        self.view.addSubview(tableView)
        textView.delegate = self
        textView.font = Font.regular(14)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            self.alertController.view.removeObserver(self, forKeyPath: "bounds")
            self.dismiss(animated: true , completion: nil)
            if self.textView.text != "   Start typing to leave a note" || self.textView.text.count != 0 {
                self.saveMutation(content:self.textView.text )
            }
        }
        
        saveAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            self.alertController.view.removeObserver(self, forKeyPath: "bounds")
           
            self.dismiss(animated: true , completion: nil)
        }
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextViewTextDidChange, object: textView, queue: OperationQueue.main) { (notification) in
            saveAction.isEnabled = self.textView.text != "   Start typing to leave a note"
        }
        textView.text = "   Start typing to leave a note"
        textView.backgroundColor = .clear
        alertController.view.addSubview(self.textView)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noteButton.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(Constants.SCREEN_WIDTH/2)
        }
        
        emailButton.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(Constants.SCREEN_WIDTH/2)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(noteButton.snp.bottom)
        }
    }
 
    
    func saveMutation(content:String) {
        var contentType = String()
        if isCompany {
            contentType = "company"
        } else {
            contentType = "customer"
        }
        let mutation = InternalNotesAddMutation(contentType: contentType)
        mutation.content = content
        mutation.contentTypeId = contactId
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                self?.showResult(isSuccess: false, message: error.localizedDescription,resultCompletion: nil)
                
                return
            }
            if let err = result?.errors {
                print(err[0].localizedDescription)
                self?.showResult(isSuccess: false, message: err[0].localizedDescription,resultCompletion: nil)
                
            }
            if result?.data != nil {
                if (result?.data?.internalNotesAdd?.id) != nil {
                    self?.showResult(isSuccess: true, message: "Changes Saved Successfully",resultCompletion: {
                        self?.delegate?.reloadData()
                    })
                    
                }
                
                
            }
        }
    }
}

extension NoteController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.notes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.notes[section].list.count)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: 40))
        headerView.backgroundColor = UIColor.init(hexString: "ebebeb")
        let iconView = UIImageView(frame: CGRect(x: 16, y: 9, width: 20, height: 20))
        iconView.image = UIImage.erxes(with: .calendar, textColor: .LIGHT_GRAY_COLOR)
        iconView.contentMode = .scaleAspectFit
        headerView.addSubview(iconView)
        let label = UILabel(frame: CGRect(x: 48, y: 0, width: Constants.SCREEN_WIDTH-64, height: 40))
        label.textColor = .black
        label.font = Font.regular(14)
        let date = notes[section].date
        let monthName = DateFormatter().monthSymbols![(date.month)!]
        label.text = String(format: "%@ %i", monthName, (date.year)!)
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = notes[indexPath.section].list[indexPath.row]
        let date = data?.createdAt.dateFromUnixTime()
        let now = Date()
        let dateLblValue = self.getTimeComponentString(olderDate: date!, newerDate: now)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCellCon", for: indexPath) as? ActivityCellCon {
                cell.descLabel.text = "left a note"
                cell.avatarView.image = UIImage(named: "avatar.png")
                cell.dateLabel.text = dateLblValue
                cell.messageLabel.text = data?.content
                if let userName = data?.by?.details?.fullName {
                    cell.descLabel.text  = userName + " left a note"
                }
                if let avatarUrl = data?.by?.details?.avatar {
                    cell.avatarView.sd_setImage(with: URL(string: avatarUrl), placeholderImage: UIImage(named: "avatar.png"))
                }
                
                cell.iconView.image = UIImage.erxes(with: .pushpin, textColor: .white, size: CGSize(width: 12, height: 12))
                cell.iconView.backgroundColor = UIColor.init(hexString: "f8cf5f")
                return cell
            }
      
        
        return UITableViewCell()
    }
    
    func getTimeComponentString(olderDate older: Date, newerDate newer: Date) -> (String?) {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        
        let componentsLeftTime = Calendar.current.dateComponents([.minute, .hour, .day, .month, .weekOfMonth, .year], from: older, to: newer)
        
        let year = componentsLeftTime.year ?? 0
        if year > 0 {
            formatter.allowedUnits = [.year]
            return formatter.string(from: older, to: newer)
        }
        
        
        let month = componentsLeftTime.month ?? 0
        if month > 0 {
            formatter.allowedUnits = [.month]
            return formatter.string(from: older, to: newer)
        }
        
        let weekOfMonth = componentsLeftTime.weekOfMonth ?? 0
        if weekOfMonth > 0 {
            formatter.allowedUnits = [.weekOfMonth]
            return formatter.string(from: older, to: newer)
        }
        
        let day = componentsLeftTime.day ?? 0
        if day > 0 {
            formatter.allowedUnits = [.day]
            return formatter.string(from: older, to: newer)
        }
        
        let hour = componentsLeftTime.hour ?? 0
        if hour > 0 {
            formatter.allowedUnits = [.hour]
            return formatter.string(from: older, to: newer)
        }
        
        let minute = componentsLeftTime.minute ?? 0
        if minute > 0 {
            formatter.allowedUnits = [.minute]
            return formatter.string(from: older, to: newer) ?? ""
        }
        
        return nil
}
}

extension NoteController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "   Start typing to leave a note" {
            textView.text = ""
        }
    }
}

extension NoteController: MFMailComposeViewControllerDelegate {

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
