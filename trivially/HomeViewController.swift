//
//  ViewController.swift
//  trivially
//
//  Created by Amit Levy on 14/05/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblHomeScore: UILabel!
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHomeScore.text = "Last Score: \(score)"
    }

    @IBAction func btnStart(_ sender: UIButton!) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "game") as! GameViewController
        present(vc, animated: true)
        
        
    }
}


