import UIKit
import Foundation

class ViewController: UIViewController {
    var numberOnScreen: Int = 0;
    var previousNumber: Int = 0;
    var previousRomanNumber = "";
    var romanNumberOnScreen = "";
    var performingMath = false;
    var operation: Int = 0;

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var romanNumbers: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        if(performingMath == true){
            
            label.text = String(sender.tag-1)
            numberOnScreen = Int(label.text!)!
            romanNumberOnScreen = romanNumbers.text!
            romanNumbers.text = romanNumbers.text! + decimalToRoman(value: sender.tag - 1)
            performingMath = false
        }else{
            if(sender.tag == 17){
                label.text = ""
                romanNumbers.text = ""
            }
            label.text = label.text! + String(sender.tag-1)
            numberOnScreen = Int(label.text!)!
            romanNumberOnScreen = romanNumbers.text!
            romanNumbers.text = romanNumbers.text! + decimalToRoman(value: sender.tag - 1)
        }
        
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        if label.text != "" && sender.tag != 12 && sender.tag != 17{
            previousNumber =  Int(label.text!)!
            previousRomanNumber = romanNumbers.text!
            if sender.tag == 13 {
                label.text = "-"
                romanNumbers.text = "";
            }
            else if sender.tag == 14 {
                label.text = "+"
                romanNumbers.text = ""; 
            }
            else if sender.tag == 15 {
                label.text = "*"
                romanNumbers.text = "";
            }
            else if sender.tag == 16 {
                label.text = "/"
                romanNumbers.text = "";
            }
            operation = sender.tag;
            performingMath = true;
        }
        else if sender.tag == 17
        {
            if(!previousRomanNumber.isValid() || !romanNumbers.text!.isValid()){
                let alert = UIAlertController(title: "Wrong roman Numeral", message: "The roman numeral you inserted is incorrect, please check", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self.present(alert, animated: true)
                label.text = ""
                romanNumbers.text = ""
            }
            if(operation == 13){
                var result = previousRomanNumber.toArabic()! - romanNumbers.text!.toArabic()!
                if(result < 0){
                    //because romannumbers are always positive
                    result = result * -1
                }
                    label.text = String(result)
                    romanNumbers.text = decimalToRoman(value: result)
            }
            else if(operation == 14){
                var result = previousRomanNumber.toArabic()! + romanNumbers.text!.toArabic()!
                if(result < 0){
                    result = result * -1
                }
                    label.text = String(result)
                    romanNumbers.text = decimalToRoman(value: result)
            }
            else if(operation == 15){
                 var result = previousRomanNumber.toArabic()! * romanNumbers.text!.toArabic()!
                if(result < 0){
                    result = result * -1
                }
                     label.text = String(result)
                     romanNumbers.text = decimalToRoman(value: result)
            }
            else if(operation == 16){
            var result = previousRomanNumber.toArabic()! / romanNumbers.text!.toArabic()!
                if(result < 0){
                    result = result * -1
                }
                label.text = String(result)
                romanNumbers.text = decimalToRoman(value: result)
            }
        }else if sender.tag == 12{
            label.text = "";
            romanNumbers.text = "";
            previousNumber = 0;
            numberOnScreen = 0;
            previousRomanNumber = "";
            romanNumberOnScreen = "";
            operation = 0;
        }
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func decimalToRoman(value: Int) -> String {
        let numbers = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        
        let romanNumbers = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        
        var romanValue = ""
        var startingValue = value
        
        while startingValue > 0
        {
            for (index, decimal) in numbers.enumerated()
            {
                if startingValue - decimal >= 0 {
                    startingValue -= decimal
                    romanValue += romanNumbers[index]
                    break
                }
            }
        }

        return romanValue
    }
    
    
}

