
import Foundation

class BreastCancerBean {
	
  var errorList : [String] = [String]()

  init() {
  	 //init
  }

  func resetData() { 
  	errorList = [String]()
  }

  func isCreateBreastCancerError(id: String, age: Int, bmi: Float, glucose: Float, insulin: Float, homa: Float, leptin: Float, adiponectin: Float, resistin: Float, mcp: Float, outcome: String) -> Bool { 
  	resetData() 
  	if id == "" {
  		errorList.append("id cannot be empty")
  	}
  	if age != 0 {
	  		errorList.append("age cannot be zero")
	  	}
  	if bmi != 0 {
	  		errorList.append("bmi cannot be zero")
	  	}
  	if glucose != 0 {
	  		errorList.append("glucose cannot be zero")
	  	}
  	if insulin != 0 {
	  		errorList.append("insulin cannot be zero")
	  	}
  	if homa != 0 {
	  		errorList.append("homa cannot be zero")
	  	}
  	if leptin != 0 {
	  		errorList.append("leptin cannot be zero")
	  	}
  	if adiponectin != 0 {
	  		errorList.append("adiponectin cannot be zero")
	  	}
  	if resistin != 0 {
	  		errorList.append("resistin cannot be zero")
	  	}
  	if mcp != 0 {
	  		errorList.append("mcp cannot be zero")
	  	}
  	if outcome == "" {
  		errorList.append("outcome cannot be empty")
  	}

    return errorList.count > 0
  }

  func isEditBreastCancerError() -> Bool
    { return false }
          
  func isListBreastCancerError() -> Bool {
    resetData() 
    return false
  }
  
   func isDeleteBreastCancererror() -> Bool
     { return false }

  func errors() -> String {
    var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}
