//
//  SearchViewController.swift
//  SearchResult
//
//  Created by Neeleshwari Mehra on 23/03/21.
//  Copyright © 2021 Hiteshi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
 

    //
    //Outlets
    //
    
    @IBOutlet var tblViewSearch: UITableView!
    @IBOutlet var tfSearch: UITextField!
    @IBOutlet var lblTitleSearch: UILabel!
    @IBOutlet var lblSearchResult: UILabel!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var btnClear: UIButton!
    @IBOutlet var collectionFilter: UICollectionView!
    @IBOutlet var tagView: TaglistCollection!
    @IBOutlet var viewTagConstraintHt: NSLayoutConstraint!
  
    //
    //Variables
    //
    
    var arrListJSON = NSMutableArray()
    var arrBlockList = NSMutableArray()
    var  arrTagTitle = NSMutableArray()
    var  arrSearched = NSMutableArray()
    
      // MARK: - Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayAndDelegates()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show()
        parseActivityData()
    }
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    // MARK: - Functions
    func displayAndDelegates()  {
        setGradientBackground()
        tblViewSearch.delegate = self
        tblViewSearch.dataSource = self
        
        collectionFilter.delegate = self
        collectionFilter.dataSource = self
        
         tfSearch.delegate = self
         tblViewSearch.isHidden = false
         lblSearchResult.isHidden = true
         btnClear.isHidden = true
        viewSearch.addBottomBorder(color: UIColor.white, height: 1)
        tfSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfSearch.placeholderColor(color: UIColor.lightGray)
        arrBlockList = ["All","Tower A","Tower B","Tower C","Tower D" ,"Tower E"]
        setupTaglistView()
    }
    
    func setupTaglistView() {
         
         self.tagView.setupTagCollection()
         self.tagView.delegate = self
         self.tagView.textFont = UIFont.systemFont(ofSize: 17.0, weight: .heavy)
        self.tagView.tagBackgroundColor = UIColor.black
      
     }
     
    
    // MARK: - Button Action
    @IBAction func btnClear(_ sender: Any) {
        tfSearch.text = ""
        arrSearched = arrListJSON
        tblViewSearch.isHidden = false
        lblSearchResult.isHidden = true
        btnClear.isHidden = true
        implementingSeaching()
        self.tagView.removeAllTags()
        
    }
    
       // MARK: - implementingSeaching====NEELESHWARI_=======
       @objc func textFieldDidChange(_ textField: UITextField) {
           
          // print("text field",tfSearch.text ?? "")
        
              if tfSearch.text?.count == 0{
                  tfSearch.text = ""
                 self.tagView.removeAllTags()
                  self.hideKeyboard()
                  
              }else{
                  self.implementingSeaching()
              }
        
       }
      
    
       func implementingSeaching() {
           
            arrSearched = NSMutableArray()
           
           if tfSearch.text?.count != 0{
               
               for i in 0..<arrListJSON.count {
                   
                   if let dictObject: NSDictionary = arrListJSON.object(at: i) as? NSDictionary{
                       
                    let searchedTxt = (tfSearch.text ?? "").lowercased()
                      
                    let title = string(dictObject, "title").lowercased()
                       let activity_name = string(dictObject, "activity_name").lowercased()
                       let step_name = string(dictObject, "step_name").lowercased()
                         let block_name = string(dictObject, "block_name").lowercased()
                       
                    if title.contains(searchedTxt) || activity_name.contains(searchedTxt) || step_name.contains(searchedTxt) || block_name.contains(searchedTxt)
                           
                       {
                        if arrTagTitle.count == 0 {
                                          
                            arrSearched.add(dictObject)
                        }else{
                            
                            for i in 0..<arrTagTitle.count {
                                let title = arrTagTitle.object(at: i) as! String
                                if title.contains(title) || activity_name.contains(title) || step_name.contains(title) || block_name.contains(title){
                                    arrSearched.add(dictObject)
                                }
                            }
                            
                        }
                       }
                   }
               }
          
            
               if arrSearched.count == 0{
                   lblSearchResult.isHidden = false
                   tblViewSearch.isHidden = true
                   
                   lblSearchResult.text = "Term\"\(tfSearch.text ?? "")\" not found"
                   
               }else{
                   tblViewSearch.isHidden = false
                   lblSearchResult.isHidden = true
               }
               
           }else{
               arrSearched = arrListJSON
               tblViewSearch.isHidden = false
               lblSearchResult.isHidden = true
                btnClear.isHidden = true
           }
        
           tblViewSearch.reloadData()
       }
    
    func implementingBlockFilter(strSelectedBlock:String) {
        tfSearch.text = ""
        tblViewSearch.isHidden = false
        lblSearchResult.isHidden = true
        btnClear.isHidden = true
        arrSearched  = NSMutableArray()
        
        if strSelectedBlock == "All"{
            arrSearched = arrListJSON
            
        }else{
            for i in 0..<arrListJSON.count {
                      
                    let dict = arrListJSON.object(at: i) as! NSDictionary
                    let  block_name = string(dict, "block_name")
                      
                    if block_name == strSelectedBlock{
                        arrSearched.add(dict)
                    }

                }
        }
      
        tblViewSearch.reloadData()
      }
 
       ///////////===========NEELESHWARI=======
    
    // MARK: - UIStatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:Collection View
      
      func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return arrBlockList.count
          //return 3
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
          
        cell.lblName.text = arrBlockList.object(at: indexPath.row) as? String
      
          return cell
      }
     ///*
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
       let  strSelectedBlock = arrBlockList.object(at: indexPath.row) as! String
        print("strSelectedBlock--->>\(strSelectedBlock)")
        implementingBlockFilter(strSelectedBlock: strSelectedBlock)
        
      }
     // */
      // MARK: - Colletion view flow layout
      ///*
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
          return CGSize(width: collectionView.frame.size.width/3-10, height: 50)
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 5
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 5
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
      }

     // MARK: - UITableViewDelegate and UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        
            return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
      
        return arrSearched.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
         let dict = arrSearched.object(at: indexPath.row) as! NSDictionary
         cell.lblTitle.text = string(dict, "title") + " " + string(dict, "block_name") 
         cell.lblStepName.text = string(dict, "step_name")
         cell.lblActivityName.text = string(dict, "activity_name")
        cell.lblProgressPercentage.text = string(dict, "progress") + "%"
        cell.lblApt.text = string(dict, "apt") + "D."
        
        if let per:Float = dict.object(forKey: "progress") as? Float{
            cell.progressView.progress = per/100
            
            if per < 50 {
                    cell.progressView.tintColor = UIColor.red
                   }else if per < 70{
                    cell.progressView.tintColor = UIColor.orange
                   }else{
                        cell.progressView.tintColor = UIColor.green
                    }
        }
        
        return cell
    }
    
    
      // MARK: - Parsing Json Data
    
    func parseActivityData() {
     if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
 
                if let arrJson = jsonResult as? NSArray {
                    self.sortData(arrData:arrJson)
                }
                
              } catch {
                   // handle error
                print("file not found")
              }
        }

    }
    

    
    func sortData(arrData:NSArray)  {
       
   
        for i in 0..<arrData.count {
            let dict1 = arrData.object(at: i) as! NSDictionary
            
            if let units = dict1.object(forKey: "units") as? NSArray {
                            
                for j in 0..<units.count {
                     let dict2 = units.object(at: j) as! NSDictionary
                    if let activities = dict2.object(forKey: "activities") as? NSArray {
                         for k in 0..<activities.count {
                             let dict3 = activities.object(at: k) as! NSDictionary
                            let dict4 = NSMutableDictionary()
                            dict4.addEntries(from: dict3 as! [AnyHashable : Any])
                            
                            dict4.setValue(string(dict2, "apt"), forKey: "apt")
                            dict4.setValue(string(dict2, "block_id"), forKey: "block_id")
                            dict4.setValue(string(dict2, "block_name"), forKey: "block_name")
                            dict4.setValue(string(dict2, "id"), forKey: "id")
                            dict4.setValue(string(dict2, "property_id"), forKey: "property_id")
                            dict4.setValue(string(dict2, "title"), forKey: "title")
                            dict4.setValue(string(dict2, "unit_type"), forKey: "unit_type")
                            arrListJSON.add(dict4)
                        }
                    }
                }
            }
        }
            arrSearched = arrListJSON
    }
    
    ///////////===========NEELESHWARI_class=======
       //MARK:- TEXTFIELD DELEGATE
       @objc func hideKeyboard() {
           self.view.endEditing(true)
           searchTextNow()
       }
       
       func searchTextNow() {
            
        self.tagView.appendTag(tagName: tfSearch.text ?? "")
         arrTagTitle.add(tfSearch.text ?? "")
            tfSearch.text = ""
       }
       
       func textFieldDidBeginEditing(_ textField: UITextField) {
           
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           if textField == tfSearch {
               tfSearch.resignFirstResponder()
              searchTextNow()
           }
           return true
       }
       
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           
           let length = (textField.text?.count)! + string.count - range.length
           if length != 0{
                      btnClear.isHidden = false
                  }else{
                      btnClear.isHidden = true
                  }
                  
           if textField == tfSearch {
               
               return (length > 50) ? false : true
               
           }
           
           return true
       }
       
       func textFieldDidEndEditing(_ textField: UITextField) {
           
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
       }

    
  

}
  //TAG VIEW

extension SearchViewController : TagViewDelegate {
    
   
    
    func didRemoveTag(_ indexPath: IndexPath) {
        implementingSeaching()
    }
    
    func didTaponTag(_ indexPath: IndexPath) {
        
    }
   
}

