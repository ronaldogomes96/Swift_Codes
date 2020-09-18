//
//  CollectionProgress.swift
//  TesteXib
//
//  Created by Ronaldo Gomes on 15/09/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class CollectionProgress: UIView {

    static let nibName = "CollectionProgress"
    static let identifier = "CollectionProgress"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var viewXib: UIView!
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        //configure()
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        setup()
        //configure()
    }
    
    /*
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
        setup()
    }
    */
    func configure() {
        //self.backgroundColor = .red
        //Bundle.main.loadNibNamed("CollectionProgress", owner: self, options: nil)
    }
    
    func setup() {
        self.viewXib = self.loadViewFromNib()
        self.viewXib.frame = bounds
        self.addSubview(self.viewXib)

    }

    func loadViewFromNib() -> UIView {
        let nib: UINib = UINib(nibName: "CollectionProgress", bundle: .main)
        let view: UIView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }
}
