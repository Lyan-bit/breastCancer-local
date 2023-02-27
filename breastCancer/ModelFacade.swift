	                  
import Foundation
import SwiftUI

/* This code requires OclFile.swift */

func initialiseOclFile()
{ 
  //let systemIn = createByPKOclFile(key: "System.in")
  //let systemOut = createByPKOclFile(key: "System.out")
  //let systemErr = createByPKOclFile(key: "System.err")
}

/* This metatype code requires OclType.swift */

func initialiseOclType()
{ let intOclType = createByPKOclType(key: "int")
  intOclType.actualMetatype = Int.self
  let doubleOclType = createByPKOclType(key: "double")
  doubleOclType.actualMetatype = Double.self
  let longOclType = createByPKOclType(key: "long")
  longOclType.actualMetatype = Int64.self
  let stringOclType = createByPKOclType(key: "String")
  stringOclType.actualMetatype = String.self
  let sequenceOclType = createByPKOclType(key: "Sequence")
  sequenceOclType.actualMetatype = type(of: [])
  let anyset : Set<AnyHashable> = Set<AnyHashable>()
  let setOclType = createByPKOclType(key: "Set")
  setOclType.actualMetatype = type(of: anyset)
  let mapOclType = createByPKOclType(key: "Map")
  mapOclType.actualMetatype = type(of: [:])
  let voidOclType = createByPKOclType(key: "void")
  voidOclType.actualMetatype = Void.self
	
  let breastCancerOclType = createByPKOclType(key: "BreastCancer")
  breastCancerOclType.actualMetatype = BreastCancer.self

  let breastCancerId = createOclAttribute()
  	  breastCancerId.name = "id"
  	  breastCancerId.type = stringOclType
  	  breastCancerOclType.attributes.append(breastCancerId)
  let breastCancerAge = createOclAttribute()
  	  breastCancerAge.name = "age"
  	  breastCancerAge.type = intOclType
  	  breastCancerOclType.attributes.append(breastCancerAge)
  let breastCancerBmi = createOclAttribute()
  	  breastCancerBmi.name = "bmi"
  	  breastCancerBmi.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerBmi)
  let breastCancerGlucose = createOclAttribute()
  	  breastCancerGlucose.name = "glucose"
  	  breastCancerGlucose.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerGlucose)
  let breastCancerInsulin = createOclAttribute()
  	  breastCancerInsulin.name = "insulin"
  	  breastCancerInsulin.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerInsulin)
  let breastCancerHoma = createOclAttribute()
  	  breastCancerHoma.name = "homa"
  	  breastCancerHoma.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerHoma)
  let breastCancerLeptin = createOclAttribute()
  	  breastCancerLeptin.name = "leptin"
  	  breastCancerLeptin.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerLeptin)
  let breastCancerAdiponectin = createOclAttribute()
  	  breastCancerAdiponectin.name = "adiponectin"
  	  breastCancerAdiponectin.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerAdiponectin)
  let breastCancerResistin = createOclAttribute()
  	  breastCancerResistin.name = "resistin"
  	  breastCancerResistin.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerResistin)
  let breastCancerMcp = createOclAttribute()
  	  breastCancerMcp.name = "mcp"
  	  breastCancerMcp.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerMcp)
  let breastCancerOutcome = createOclAttribute()
  	  breastCancerOutcome.name = "outcome"
  	  breastCancerOutcome.type = stringOclType
  	  breastCancerOclType.attributes.append(breastCancerOutcome)
}

func instanceFromJSON(typeName: String, json: String) -> AnyObject?
	{ let jdata = json.data(using: .utf8)!
	  let decoder = JSONDecoder()
	  if typeName == "String"
	  { let x = try? decoder.decode(String.self, from: jdata)
	      return x as AnyObject
	  }
  return nil
	}

class ModelFacade : ObservableObject {
		                      
	static var instance : ModelFacade? = nil
	private var modelParser : ModelParser? = ModelParser(modelFileInfo: ModelFile.modelInfo)
	var db : DB?
		
	// path of document directory for SQLite database (absolute path of db)
	let dbpath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
	var fileSystem : FileAccessor = FileAccessor()

	static func getInstance() -> ModelFacade { 
		if instance == nil
	     { instance = ModelFacade() 
	       initialiseOclFile()
	       initialiseOclType() }
	    return instance! }
	                          
	init() { 
		// init
		db = DB.obtainDatabase(path: "\(dbpath)/myDatabase.sqlite3")
		loadBreastCancer()
	}
	      
	@Published var currentBreastCancer : BreastCancerVO? = BreastCancerVO.defaultBreastCancerVO()
	@Published var currentBreastCancers : [BreastCancerVO] = [BreastCancerVO]()

	func createBreastCancer(x : BreastCancerVO) {
		let res : BreastCancer = createByPKBreastCancer(key: x.id)
			res.id = x.id
		res.age = x.age
		res.bmi = x.bmi
		res.glucose = x.glucose
		res.insulin = x.insulin
		res.homa = x.homa
		res.leptin = x.leptin
		res.adiponectin = x.adiponectin
		res.resistin = x.resistin
		res.mcp = x.mcp
		res.outcome = x.outcome
	    currentBreastCancer = x

	    do { try db?.createBreastCancer(breastCancervo: x) }
	    catch { print("Error creating BreastCancer") }
	}
	
	func cancelCreateBreastCancer() {
		//cancel function
	}

    func classifyBreastCancer(x : String) -> String {
        guard let breastCancer = getBreastCancerByPK(val: x)
        else {
            return "Please selsect valid id"
        }
        
        guard let result = self.modelParser?.runModel(
          input0: Float((breastCancer.age - 24) / (89 - 24)),
          input1: Float((breastCancer.bmi - 18.37) / (38.5787585 - 18.37)),
          input2: Float((breastCancer.glucose - 60) / (201 - 60)),
          input3: Float((breastCancer.insulin - 2.432) / (58.46 - 2.432)),
          input4: Float((breastCancer.homa - 4.311) / (90.28 - 4.311)),
          input5: Float((breastCancer.leptin - 1.6502) / (38.4 - 1.6502)),
          input6: Float((breastCancer.adiponectin - 3.21) / (82.1 - 3.21)),
          input7: Float((breastCancer.resistin - 45.843) / (1698.44 - 45.843)),
          input8: Float((breastCancer.mcp - 45.843) / (1698.44 - 45.843))
        ) else{
            return "Error"
        }
        
        breastCancer.outcome = result
        persistBreastCancer(x: breastCancer)
        
        return result
	}
	
	func cancelClassifyBreastCancer() {
		//cancel function
	}
	    

	func loadBreastCancer() {
		let res : [BreastCancerVO] = listBreastCancer()
		
		for (_,x) in res.enumerated() {
			let obj = createByPKBreastCancer(key: x.id)
	        obj.id = x.getId()
        obj.age = x.getAge()
        obj.bmi = x.getBmi()
        obj.glucose = x.getGlucose()
        obj.insulin = x.getInsulin()
        obj.homa = x.getHoma()
        obj.leptin = x.getLeptin()
        obj.adiponectin = x.getAdiponectin()
        obj.resistin = x.getResistin()
        obj.mcp = x.getMcp()
        obj.outcome = x.getOutcome()
			}
		 currentBreastCancer = res.first
		 currentBreastCancers = res
		}
		
  		func listBreastCancer() -> [BreastCancerVO] {
			if db != nil
			{ currentBreastCancers = (db?.listBreastCancer())!
			  return currentBreastCancers
			}
			currentBreastCancers = [BreastCancerVO]()
			let list : [BreastCancer] = BreastCancerAllInstances
			for (_,x) in list.enumerated()
			{ currentBreastCancers.append(BreastCancerVO(x: x)) }
			return currentBreastCancers
		}
				
		func stringListBreastCancer() -> [String] { 
			currentBreastCancers = listBreastCancer()
			var res : [String] = [String]()
			for (_,obj) in currentBreastCancers.enumerated()
			{ res.append(obj.toString()) }
			return res
		}
				
		func getBreastCancerByPK(val: String) -> BreastCancer? {
			var res : BreastCancer? = BreastCancer.getByPKBreastCancer(index: val)
			if res == nil && db != nil
			{ let list = db!.searchByBreastCancerid(val: val)
			if list.count > 0
			{ res = createByPKBreastCancer(key: val)
			}
		  }
		  return res
		}
				
		func retrieveBreastCancer(val: String) -> BreastCancer? {
			let res : BreastCancer? = getBreastCancerByPK(val: val)
			return res 
		}
				
		func allBreastCancerids() -> [String] {
			var res : [String] = [String]()
			for (_,item) in currentBreastCancers.enumerated()
			{ res.append(item.id + "") }
			return res
		}
				
		func setSelectedBreastCancer(x : BreastCancerVO)
			{ currentBreastCancer = x }
				
		func setSelectedBreastCancer(i : Int) {
			if 0 <= i && i < currentBreastCancers.count
			{ currentBreastCancer = currentBreastCancers[i] }
		}
				
		func getSelectedBreastCancer() -> BreastCancerVO?
			{ return currentBreastCancer }
				
		func persistBreastCancer(x : BreastCancer) {
			let vo : BreastCancerVO = BreastCancerVO(x: x)
			editBreastCancer(x: vo)
		}
			
		func editBreastCancer(x : BreastCancerVO) {
			let val : String = x.id
			let res : BreastCancer? = BreastCancer.getByPKBreastCancer(index: val)
			if res != nil {
			res!.id = x.id
		res!.age = x.age
		res!.bmi = x.bmi
		res!.glucose = x.glucose
		res!.insulin = x.insulin
		res!.homa = x.homa
		res!.leptin = x.leptin
		res!.adiponectin = x.adiponectin
		res!.resistin = x.resistin
		res!.mcp = x.mcp
		res!.outcome = x.outcome
		}
		currentBreastCancer = x
			if db != nil
			 { db!.editBreastCancer(breastCancervo: x) }
		 }
			
	    func cancelBreastCancerEdit() {
	    	//cancel function
	    }
	    
 	func searchByBreastCancerid(val : String) -> [BreastCancerVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByBreastCancerid(val: val))!
		          return res
		        }
		    currentBreastCancers = [BreastCancerVO]()
		    let list : [BreastCancer] = BreastCancerAllInstances
		    for (_,x) in list.enumerated()
		    { if x.id == val
		      { currentBreastCancers.append(BreastCancerVO(x: x)) }
		    }
		    return currentBreastCancers
		  }
		  
 	func searchByBreastCancerage(val : Int) -> [BreastCancerVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByBreastCancerage(val: val))!
		          return res
		        }
		    currentBreastCancers = [BreastCancerVO]()
		    let list : [BreastCancer] = BreastCancerAllInstances
		    for (_,x) in list.enumerated()
		    { if x.age == val
		      { currentBreastCancers.append(BreastCancerVO(x: x)) }
		    }
		    return currentBreastCancers
		  }
		  
 	func searchByBreastCancerbmi(val : Float) -> [BreastCancerVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByBreastCancerbmi(val: val))!
		          return res
		        }
		    currentBreastCancers = [BreastCancerVO]()
		    let list : [BreastCancer] = BreastCancerAllInstances
		    for (_,x) in list.enumerated()
		    { if x.bmi == val
		      { currentBreastCancers.append(BreastCancerVO(x: x)) }
		    }
		    return currentBreastCancers
		  }
		  
 	func searchByBreastCancerglucose(val : Float) -> [BreastCancerVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByBreastCancerglucose(val: val))!
		          return res
		        }
		    currentBreastCancers = [BreastCancerVO]()
		    let list : [BreastCancer] = BreastCancerAllInstances
		    for (_,x) in list.enumerated()
		    { if x.glucose == val
		      { currentBreastCancers.append(BreastCancerVO(x: x)) }
		    }
		    return currentBreastCancers
		  }
		  
 	func searchByBreastCancerinsulin(val : Float) -> [BreastCancerVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByBreastCancerinsulin(val: val))!
		          return res
		        }
		    currentBreastCancers = [BreastCancerVO]()
		    let list : [BreastCancer] = BreastCancerAllInstances
		    for (_,x) in list.enumerated()
		    { if x.insulin == val
		      { currentBreastCancers.append(BreastCancerVO(x: x)) }
		    }
		    return currentBreastCancers
		  }
		  
 	func searchByBreastCancerhoma(val : Float) -> [BreastCancerVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByBreastCancerhoma(val: val))!
		          return res
		        }
		    currentBreastCancers = [BreastCancerVO]()
		    let list : [BreastCancer] = BreastCancerAllInstances
		    for (_,x) in list.enumerated()
		    { if x.homa == val
		      { currentBreastCancers.append(BreastCancerVO(x: x)) }
		    }
		    return currentBreastCancers
		  }
		  
 	func searchByBreastCancerleptin(val : Float) -> [BreastCancerVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByBreastCancerleptin(val: val))!
		          return res
		        }
		    currentBreastCancers = [BreastCancerVO]()
		    let list : [BreastCancer] = BreastCancerAllInstances
		    for (_,x) in list.enumerated()
		    { if x.leptin == val
		      { currentBreastCancers.append(BreastCancerVO(x: x)) }
		    }
		    return currentBreastCancers
		  }
		  
 	func searchByBreastCanceradiponectin(val : Float) -> [BreastCancerVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByBreastCanceradiponectin(val: val))!
		          return res
		        }
		    currentBreastCancers = [BreastCancerVO]()
		    let list : [BreastCancer] = BreastCancerAllInstances
		    for (_,x) in list.enumerated()
		    { if x.adiponectin == val
		      { currentBreastCancers.append(BreastCancerVO(x: x)) }
		    }
		    return currentBreastCancers
		  }
		  
 	func searchByBreastCancerresistin(val : Float) -> [BreastCancerVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByBreastCancerresistin(val: val))!
		          return res
		        }
		    currentBreastCancers = [BreastCancerVO]()
		    let list : [BreastCancer] = BreastCancerAllInstances
		    for (_,x) in list.enumerated()
		    { if x.resistin == val
		      { currentBreastCancers.append(BreastCancerVO(x: x)) }
		    }
		    return currentBreastCancers
		  }
		  
 	func searchByBreastCancermcp(val : Float) -> [BreastCancerVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByBreastCancermcp(val: val))!
		          return res
		        }
		    currentBreastCancers = [BreastCancerVO]()
		    let list : [BreastCancer] = BreastCancerAllInstances
		    for (_,x) in list.enumerated()
		    { if x.mcp == val
		      { currentBreastCancers.append(BreastCancerVO(x: x)) }
		    }
		    return currentBreastCancers
		  }
		  
 	func searchByBreastCanceroutcome(val : String) -> [BreastCancerVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByBreastCanceroutcome(val: val))!
		          return res
		        }
		    currentBreastCancers = [BreastCancerVO]()
		    let list : [BreastCancer] = BreastCancerAllInstances
		    for (_,x) in list.enumerated()
		    { if x.outcome == val
		      { currentBreastCancers.append(BreastCancerVO(x: x)) }
		    }
		    return currentBreastCancers
		  }
		  

	}
