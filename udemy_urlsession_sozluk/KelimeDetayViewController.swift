//
//  KelimeDetayViewController.swift
//  udemy_urlsession_sozluk
//
//  Created by Eren Demir on 13.05.2022.
//

import UIKit

class KelimeDetayViewController: UIViewController {
    @IBOutlet weak var ingilizceLabel: UILabel!
    @IBOutlet weak var turkceLabel: UILabel!
    var kelime:Kelime?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let k = kelime {
            ingilizceLabel.text = k.ingilizce
            turkceLabel.text = k.turkce
        }
    }
    

}
