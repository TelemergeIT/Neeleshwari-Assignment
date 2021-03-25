//
//  SplashViewController.swift
//  SearchResult
//
//  Created by Neeleshwari Mehra on 23/03/21.
//  Copyright © 2021 Hiteshi. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // SVProgressHUD.show()
        goToSearchScreen()
    }
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.setNavigationBarHidden(true, animated: true)
       }
    // MARK: - Navigation
    func goToSearchScreen()  {
         let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
         self.navigationController?.pushViewController(vc, animated: true)
     }
     
}
