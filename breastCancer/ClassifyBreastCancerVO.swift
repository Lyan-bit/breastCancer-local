
import Foundation

class ClassifyBreastCancerVO {
  var breastCancer : String = ""

  static var defaultInstance : ClassifyBreastCancerVO? = nil
  var errorList : [String] = [String]()

  var result : String = ""

  init() {
  	//init
  }
  
  static func defaultClassifyBreastCancerVO() -> ClassifyBreastCancerVO
  { if defaultInstance == nil
    { defaultInstance = ClassifyBreastCancerVO() }
    return defaultInstance!
  }

  init(breastCancerx: String)  {
  breastCancer = breastCancerx
  }

  func toString() -> String
  	{ return "" + "breastCancer = " + breastCancer }

  func getBreastCancer() -> BreastCancer
  	{ return BreastCancer.breastCancerIndex[breastCancer]! }
  	
  func setBreastCancer(x : BreastCancer)
  	{ breastCancer = x.id }
			  
  func setResult (x: String) {
    result = x }
          
  func resetData()
  	{ errorList = [String]() }

  func isClassifyBreastCancerError() -> Bool
  	{ resetData()
  
 if BreastCancer.breastCancerIndex[breastCancer] == nil
	{ errorList.append("Invalid breastCancer id: " + breastCancer) }


    if errorList.count > 0
    { return true }
    
    return false
  }

  func errors() -> String
  { var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}

