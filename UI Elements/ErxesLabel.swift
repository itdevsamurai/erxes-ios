import Foundation
import UIKit

class ErxesLabel : UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        self.setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.setup()
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
  
    
 
    
    func setup() {
        
        self.font = Font.light(14)
   
        self.layer.display()
    }
    
    
 
    

    

}
