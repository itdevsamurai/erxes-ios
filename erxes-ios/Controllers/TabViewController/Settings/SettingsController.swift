//
//  SettingsController.swift
//  erxes-ios
//
//  Created by Soyombo bat-erdene on 8/30/18.
//  Copyright © 2018 Erxes Inc. All rights reserved.
//

import UIKit
import Apollo
import Photos
import Alamofire
class SettingsController: UIViewController {

    var size = 0
    
    var userData = [UserDetailQuery.Data.UserDetail]()
    var titles = ["Change Password","Email signatures","Notification settings","Sign Out"]
    var icons:[ErxesFont] = [.openlock, .email1, .switch3, .logout2]
    var autoCompleteCharacterCount = 0
    var timer = Timer()
    var brands = [BrandDetail]()
    
    var profileView:ProfileView?
    
    
   
    var tableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .clear
        tableview.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        
        tableview.rowHeight = 40
        tableview.tableFooterView = UIView()         
        return tableview
    }()
    
    func configureViews() {
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let currentUser = ErxesUser.sharedUserInfo()
        profileView = ProfileView(user: currentUser)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTap(tapGesture:)))
        profileView!.avatarView.addGestureRecognizer(tapGesture)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        profileView?.addGestureRecognizer(tap)
       
//        tableView.tableHeaderView = profileView
        self.view.addSubview(profileView!)
        
        let backGroundImage = UIImage(named: "profileBackground")
        let ratio = CGFloat((backGroundImage!.size.width)) / CGFloat((backGroundImage!.size.height))
        let imageHeight = (Constants.SCREEN_WIDTH)/ratio
        tableView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
        tableView.reloadData()
    }
    
    @objc func handleTap(sender:UITapGestureRecognizer) {
        let currentUser = ErxesUser.sharedUserInfo()
        self.navigate(.userProfile(id: currentUser._id!))
    }
    
    @objc func imageTap(tapGesture:UITapGestureRecognizer) {
        self.checkPermission()
    }
    
    @objc func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.navigationBar.barStyle = .default
        imagePicker.navigationBar.tintColor = .ERXES_COLOR

        DispatchQueue.main.async {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func checkPermission() {
        
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    self.openImagePicker()
                } else {
                }
            })
        } else {
            self.openImagePicker()
        }
    }
    
    func uploadFile(image:UIImage) {

        let url = Constants.URL_UPLOAD
        
        if let imgData = UIImage.resize(image) as? Data{
            size = imgData.count
            let bcf = ByteCountFormatter()
            bcf.allowedUnits = [.useKB]
            bcf.countStyle = .file
            //            self.lblFilesize.text = bcf.string(fromByteCount: Int64(size))
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "file",fileName: "file.jpg", mimeType: "image/jpg")
            },
                             to:url ) {
                                (result) in
                                
                                switch result {
                                case .success(let upload, _, _):
                                    self.processUpload(upload)
                                case .failure(let encodingError):
                                    print(encodingError)
                                }
            }
        }
    }
    
    func processUpload(_ upload:UploadRequest) {
        upload.uploadProgress(closure: { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
            //            self.progress.progress = Float(progress.fractionCompleted)
        })
        
        upload.responseString { response in
            print(response)
            if let remoteUrl = response.value{
                self.presentTextFieldAlert(title: "Confirm", msg: "Enter your password to confirm") { (textValue) in
                    self.saveImage(imageUrl: remoteUrl, userPassword: textValue!)
                }
            }
        }
    }
    
    func saveImage(imageUrl:String,userPassword:String) {
        let currentUser = ErxesUser.sharedUserInfo()
        let user = self.userData[0]
        let mutation = UsersEditProfileMutation(username: currentUser.username!, email: currentUser.email!, password: userPassword)
        mutation.details = UserDetails(avatar: imageUrl, fullName: user.details?.fullName, position: user.details?.position, location: user.details?.location, description: user.details?.location)
        mutation.links? = UserLinks(linkedIn: user.links?.linkedIn, twitter: user.links?.twitter, facebook: user.links?.facebook, youtube: user.links?.youtube, github: user.links?.github, website: user.links?.website)
        appnet.perform(mutation: mutation) { [weak self] result, error in
            if let error = error {
                
                self?.showResult(isSuccess: false, message: error.localizedDescription,resultCompletion: nil)
                
                return
            }
            if let err = result?.errors {
                
                self?.showResult(isSuccess: false, message: err[0].localizedDescription,resultCompletion: nil)
                
            }
            if result?.data != nil {
                if (result?.data?.usersEditProfile) != nil {
                    self?.showResult(isSuccess: true, message: "Changes Saved Successfully",resultCompletion: {
                        currentUser.avatar = imageUrl
                        self?.profileView?.avatarView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "ic_avatar"))
                    })
                    
                }
                
                
            }
        }
    }
    
    func getUserData(id: String)  {
        
        let query = UserDetailQuery(_id: id)
        appnet.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                
                return
            }
            
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
                
            }
            
            if result?.data != nil {
                if let userData = result?.data?.userDetail {
                    
                    self?.userData = [userData]
                    
                }
                
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
         self.view.backgroundColor = UIColor.white
        
        configureViews()
        getBrands()
        getUserData(id: ErxesUser.sharedUserInfo()._id!)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currentUser = ErxesUser.sharedUserInfo()
        profileView?.user = currentUser
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileView?.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        })
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
 
    }
    
    func getBrands() {
        
        let query = BrandsQuery()
        appnet.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                let alert = FailureAlert(message: error.localizedDescription)
                alert.show(animated: true)
                
                return
            }
            
            if let err = result?.errors {
                let alert = FailureAlert(message: err[0].localizedDescription)
                alert.show(animated: true)
                
            }
            
            if result?.data != nil {
                if let allBrands = result?.data?.brands {
                    self?.brands = allBrands.map { ($0?.fragments.brandDetail)! }
                    
                    
                }
                
            }
        }
    }
    
    
}

extension SettingsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigate(.passwordSettings())
        } else if indexPath.row == 1 {
            self.navigate(.emailSignature(brands:self.brands))
        } else if indexPath.row == 2 {
            self.navigate(.notificationSettings())
        } else if indexPath.row == 3 {

            self.presentAlert(title: "Sign out", msg: "Are you sure you want to sign out ?") {
                do {
                    try ErxesUser.signOut()
                    let emptyUser = ErxesUser()
                    var currentUser = ErxesUser.sharedUserInfo()
                    currentUser = emptyUser
                    UserDefaults.standard.removeObject(forKey: "email")
                    UserDefaults.standard.synchronize()
                    self.parent?.navigationController?.popToRootViewController(animated: true)
                } catch {
                    print("sign out failure")
                }

            }
            
        }
    }
}

extension SettingsController: UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.profileView?.scrollViewDidScroll(scrollView: scrollView)

    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell)!
        cell.contentView.backgroundColor = .clear
        cell.iconType = icons[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView = UIImageView(image: UIImage.erxes(with: .chevron, textColor: .black, size: CGSize(width: 10, height: 10)))
        cell.desc.text = titles[indexPath.row]
       

        return cell
    }
}





extension SettingsController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print(info)
        
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //            ivPicked.image = chosenImage
            uploadFile(image: chosenImage)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
