
import Foundation

class BreastCancerVO : Identifiable, Decodable, Encodable {

  var id: String = ""
  var age: Int = 0
  var bmi: Float = 0.0
  var glucose: Float = 0.0
  var insulin: Float = 0.0
  var homa: Float = 0.0
  var leptin: Float = 0.0
  var adiponectin: Float = 0.0
  var resistin: Float = 0.0
  var mcp: Float = 0.0
  var outcome: String = ""

  static var defaultInstance : BreastCancerVO? = nil
  var errorList : [String] = [String]()

  init() {
  	//init
  }

  static func defaultBreastCancerVO() -> BreastCancerVO
  { if defaultInstance == nil
    { defaultInstance = BreastCancerVO() }
    return defaultInstance!
  }

  init(idx: String, agex: Int, bmix: Float, glucosex: Float, insulinx: Float, homax: Float, leptinx: Float, adiponectinx: Float, resistinx: Float, mcpx: Float, outcomex: String)  {
    id = idx
    age = agex
    bmi = bmix
    glucose = glucosex
    insulin = insulinx
    homa = homax
    leptin = leptinx
    adiponectin = adiponectinx
    resistin = resistinx
    mcp = mcpx
    outcome = outcomex
  }

  init(x : BreastCancer)  {
    id = x.id
    age = x.age
    bmi = x.bmi
    glucose = x.glucose
    insulin = x.insulin
    homa = x.homa
    leptin = x.leptin
    adiponectin = x.adiponectin
    resistin = x.resistin
    mcp = x.mcp
    outcome = x.outcome
  }

  func toString() -> String
  { return " id= \(id), age= \(age), bmi= \(bmi), glucose= \(glucose), insulin= \(insulin), homa= \(homa), leptin= \(leptin), adiponectin= \(adiponectin), resistin= \(resistin), mcp= \(mcp), outcome= \(outcome) "
  }

  func getId() -> String
	  { return id }
	
  func setId(x : String)
	  { id = x }
	  
  func getAge() -> Int
	  { return age }
	
  func setAge(x : Int)
	  { age = x }
	  
  func getBmi() -> Float
	  { return bmi }
	
  func setBmi(x : Float)
	  { bmi = x }
	  
  func getGlucose() -> Float
	  { return glucose }
	
  func setGlucose(x : Float)
	  { glucose = x }
	  
  func getInsulin() -> Float
	  { return insulin }
	
  func setInsulin(x : Float)
	  { insulin = x }
	  
  func getHoma() -> Float
	  { return homa }
	
  func setHoma(x : Float)
	  { homa = x }
	  
  func getLeptin() -> Float
	  { return leptin }
	
  func setLeptin(x : Float)
	  { leptin = x }
	  
  func getAdiponectin() -> Float
	  { return adiponectin }
	
  func setAdiponectin(x : Float)
	  { adiponectin = x }
	  
  func getResistin() -> Float
	  { return resistin }
	
  func setResistin(x : Float)
	  { resistin = x }
	  
  func getMcp() -> Float
	  { return mcp }
	
  func setMcp(x : Float)
	  { mcp = x }
	  
  func getOutcome() -> String
	  { return outcome }
	
  func setOutcome(x : String)
	  { outcome = x }
	
}
