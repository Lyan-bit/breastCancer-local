
import Foundation

class BreastCancer  {
	
  private static var instance : BreastCancer? = nil	
  
  init() { 
  	//init
  }
  
  init(copyFrom: BreastCancer) {
  	self.id = "copy" + copyFrom.id
  	self.age = copyFrom.age
  	self.bmi = copyFrom.bmi
  	self.glucose = copyFrom.glucose
  	self.insulin = copyFrom.insulin
  	self.homa = copyFrom.homa
  	self.leptin = copyFrom.leptin
  	self.adiponectin = copyFrom.adiponectin
  	self.resistin = copyFrom.resistin
  	self.mcp = copyFrom.mcp
  	self.outcome = copyFrom.outcome
  }
  
  func copy() -> BreastCancer
  { let res : BreastCancer = BreastCancer(copyFrom: self)
  	addBreastCancer(instance: res)
  	return res
  }
  
static func defaultInstanceBreastCancer() -> BreastCancer
    { if (instance == nil)
    { instance = createBreastCancer() }
    return instance!
}

deinit
{ killBreastCancer(obj: self) }	


  var id: String = ""  /* primary key */
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

  static var breastCancerIndex : Dictionary<String,BreastCancer> = [String:BreastCancer]()

  static func getByPKBreastCancer(index : String) -> BreastCancer?
  { return breastCancerIndex[index] }


}

  var BreastCancerAllInstances : [BreastCancer] = [BreastCancer]()

  func createBreastCancer() -> BreastCancer
	{ let result : BreastCancer = BreastCancer()
	  BreastCancerAllInstances.append(result)
	  return result }
  
  func addBreastCancer(instance : BreastCancer)
	{ BreastCancerAllInstances.append(instance) }

  func killBreastCancer(obj: BreastCancer)
	{ BreastCancerAllInstances = BreastCancerAllInstances.filter{ $0 !== obj } }

  func createByPKBreastCancer(key : String) -> BreastCancer
	{ var result : BreastCancer? = BreastCancer.getByPKBreastCancer(index: key)
	  if result != nil { 
	  	return result!
	  }
	  result = BreastCancer()
	  BreastCancerAllInstances.append(result!)
	  BreastCancer.breastCancerIndex[key] = result!
	  result!.id = key
	  return result! }

  func killBreastCancer(key : String)
	{ BreastCancer.breastCancerIndex[key] = nil
	  BreastCancerAllInstances.removeAll(where: { $0.id == key })
	}
	
	extension BreastCancer : Hashable, Identifiable
	{ 
	  static func == (lhs: BreastCancer, rhs: BreastCancer) -> Bool
	  {       lhs.id == rhs.id &&
      lhs.age == rhs.age &&
      lhs.bmi == rhs.bmi &&
      lhs.glucose == rhs.glucose &&
      lhs.insulin == rhs.insulin &&
      lhs.homa == rhs.homa &&
      lhs.leptin == rhs.leptin &&
      lhs.adiponectin == rhs.adiponectin &&
      lhs.resistin == rhs.resistin &&
      lhs.mcp == rhs.mcp &&
      lhs.outcome == rhs.outcome
	  }
	
	  func hash(into hasher: inout Hasher) {
    	hasher.combine(id)
    	hasher.combine(age)
    	hasher.combine(bmi)
    	hasher.combine(glucose)
    	hasher.combine(insulin)
    	hasher.combine(homa)
    	hasher.combine(leptin)
    	hasher.combine(adiponectin)
    	hasher.combine(resistin)
    	hasher.combine(mcp)
    	hasher.combine(outcome)
	  }
	}
	

