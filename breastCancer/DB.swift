import Foundation
import SQLite3

/* Code adapted from https://www.raywenderlich.com/6620276-sqlite-with-swift-tutorial-getting-started */

class DB {
  let dbPointer : OpaquePointer?
  static let dbName = "breastcancerApp.db"
  static let dbVersion = 1

  static let breastCancerTableName = "BreastCancer"
  static let breastCancerID = 0
  static let breastCancerCols : [String] = ["TableId", "id", "age", "bmi", "glucose", "insulin", "homa", "leptin", "adiponectin", "resistin", "mcp", "outcome"]
  static let breastCancerNumberCols = 0

  static let breastCancerCreateSchema =
    "create table BreastCancer (TableId integer primary key autoincrement" + 
        ", id VARCHAR(50) not null"  +
        ", age integer not null"  +
        ", bmi float not null"  +
        ", glucose float not null"  +
        ", insulin float not null"  +
        ", homa float not null"  +
        ", leptin float not null"  +
        ", adiponectin float not null"  +
        ", resistin float not null"  +
        ", mcp float not null"  +
        ", outcome VARCHAR(50) not null"  +
	"" + ")"
	
  private init(dbPointer: OpaquePointer?)
  { self.dbPointer = dbPointer }

  func createDatabase() throws
  { do 
    { 
    try createTable(table: DB.breastCancerCreateSchema)
      print("Created database")
    }
    catch { print("Errors: " + errorMessage) }
  }

  static func obtainDatabase(path: String) -> DB?
  {
    var db : DB? = nil
    if FileAccessor.fileExistsAbsolutePath(filename: path)
    { print("Database already exists")
      do
      { try db = DB.open(path: path)
        if db != nil
        { print("Opened database") }
        else
        { print("Failed to open existing database") }
      }
      catch { print("Error opening existing database") 
              return nil 
            }
    }
    else
    { print("New database will be created")
      do
      { try db = DB.open(path: path)
        if db != nil
        { print("Opened new database") 
          try db!.createDatabase() 
        }
        else
        { print("Failed to open new database") }
      }
      catch { print("Error opening new database")  
              return nil }
    }
    return db
  }

  fileprivate var errorMessage: String
  { if let errorPointer = sqlite3_errmsg(dbPointer)
    { let eMessage = String(cString: errorPointer)
      return eMessage
    } 
    else 
    { return "Unknown error from sqlite." }
  }
  
  func prepareStatement(sql: String) throws -> OpaquePointer?   
  { var statement: OpaquePointer?
    guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) 
        == SQLITE_OK
    else 
    { return nil }
    return statement
  }
  
  static func open(path: String) throws -> DB? 
  { var db: OpaquePointer?
  
    if sqlite3_open(path, &db) == SQLITE_OK 
    { return DB(dbPointer: db) }
    else 
    { defer 
      { if db != nil 
        { sqlite3_close(db) }
      }
  
      if let errorPointer = sqlite3_errmsg(db)
      { let message = String(cString: errorPointer)
        print("Error opening database: " + message)
      } 
      else 
      { print("Unknown error opening database") }
      return nil
    }
  }
  
  func createTable(table: String) throws
  { let createTableStatement = try prepareStatement(sql: table)
    defer 
    { sqlite3_finalize(createTableStatement) }
    
    guard sqlite3_step(createTableStatement) == SQLITE_DONE 
    else
    { print("Error creating table") 
      return
    }
    print("table " + table + " created.")
  }

  func listBreastCancer() -> [BreastCancerVO]
  { 
  	let statement = "SELECT * FROM BreastCancer "
  	return setDataBreastCancer(statement: statement)
  }

  func createBreastCancer(breastCancervo : BreastCancerVO) throws
  { let insertSQL : String = "INSERT INTO BreastCancer (id, age, bmi, glucose, insulin, homa, leptin, adiponectin, resistin, mcp, outcome) VALUES (" 

     + "'" + breastCancervo.getId() + "'" + "," 
     + String(breastCancervo.getAge()) + "," 
     + String(breastCancervo.getBmi()) + "," 
     + String(breastCancervo.getGlucose()) + "," 
     + String(breastCancervo.getInsulin()) + "," 
     + String(breastCancervo.getHoma()) + "," 
     + String(breastCancervo.getLeptin()) + "," 
     + String(breastCancervo.getAdiponectin()) + "," 
     + String(breastCancervo.getResistin()) + "," 
     + String(breastCancervo.getMcp()) + "," 
     + "'" + breastCancervo.getOutcome() + "'"
      + ")"
    let insertStatement = try prepareStatement(sql: insertSQL)
    defer 
    { sqlite3_finalize(insertStatement)
    }
    sqlite3_step(insertStatement)
  }

  func searchByBreastCancerid(val : String) -> [BreastCancerVO]
	  { 
	  	let statement : String = "SELECT * FROM BreastCancer WHERE id = " + "'" + val + "'" 
	  	return setDataBreastCancer(statement: statement)
	  }
	  
  func searchByBreastCancerage(val : Int) -> [BreastCancerVO]
	  { 
	  	let statement : String = "SELECT * FROM BreastCancer WHERE age = " + String( val )
	  	return setDataBreastCancer(statement: statement)
	  }
	  
  func searchByBreastCancerbmi(val : Float) -> [BreastCancerVO]
	  { 
	  	let statement : String = "SELECT * FROM BreastCancer WHERE bmi = " + String( val )
	  	return setDataBreastCancer(statement: statement)
	  }
	  
  func searchByBreastCancerglucose(val : Float) -> [BreastCancerVO]
	  { 
	  	let statement : String = "SELECT * FROM BreastCancer WHERE glucose = " + String( val )
	  	return setDataBreastCancer(statement: statement)
	  }
	  
  func searchByBreastCancerinsulin(val : Float) -> [BreastCancerVO]
	  { 
	  	let statement : String = "SELECT * FROM BreastCancer WHERE insulin = " + String( val )
	  	return setDataBreastCancer(statement: statement)
	  }
	  
  func searchByBreastCancerhoma(val : Float) -> [BreastCancerVO]
	  { 
	  	let statement : String = "SELECT * FROM BreastCancer WHERE homa = " + String( val )
	  	return setDataBreastCancer(statement: statement)
	  }
	  
  func searchByBreastCancerleptin(val : Float) -> [BreastCancerVO]
	  { 
	  	let statement : String = "SELECT * FROM BreastCancer WHERE leptin = " + String( val )
	  	return setDataBreastCancer(statement: statement)
	  }
	  
  func searchByBreastCanceradiponectin(val : Float) -> [BreastCancerVO]
	  { 
	  	let statement : String = "SELECT * FROM BreastCancer WHERE adiponectin = " + String( val )
	  	return setDataBreastCancer(statement: statement)
	  }
	  
  func searchByBreastCancerresistin(val : Float) -> [BreastCancerVO]
	  { 
	  	let statement : String = "SELECT * FROM BreastCancer WHERE resistin = " + String( val )
	  	return setDataBreastCancer(statement: statement)
	  }
	  
  func searchByBreastCancermcp(val : Float) -> [BreastCancerVO]
	  { 
	  	let statement : String = "SELECT * FROM BreastCancer WHERE mcp = " + String( val )
	  	return setDataBreastCancer(statement: statement)
	  }
	  
  func searchByBreastCanceroutcome(val : String) -> [BreastCancerVO]
	  { 
	  	let statement : String = "SELECT * FROM BreastCancer WHERE outcome = " + "'" + val + "'" 
	  	return setDataBreastCancer(statement: statement)
	  }
	  

  func editBreastCancer(breastCancervo : BreastCancerVO)
  { var updateStatement: OpaquePointer?
    let statement : String = "UPDATE BreastCancer SET " 
    + " age = " + String(breastCancervo.getAge()) 
    + "," 
    + " bmi = " + String(breastCancervo.getBmi()) 
    + "," 
    + " glucose = " + String(breastCancervo.getGlucose()) 
    + "," 
    + " insulin = " + String(breastCancervo.getInsulin()) 
    + "," 
    + " homa = " + String(breastCancervo.getHoma()) 
    + "," 
    + " leptin = " + String(breastCancervo.getLeptin()) 
    + "," 
    + " adiponectin = " + String(breastCancervo.getAdiponectin()) 
    + "," 
    + " resistin = " + String(breastCancervo.getResistin()) 
    + "," 
    + " mcp = " + String(breastCancervo.getMcp()) 
    + "," 
    + " outcome = '"+breastCancervo.getOutcome() + "'" 
    + " WHERE id = '" + breastCancervo.getId() + "'" 

    if sqlite3_prepare_v2(dbPointer, statement, -1, &updateStatement, nil) == SQLITE_OK
    { sqlite3_step(updateStatement) }
    sqlite3_finalize(updateStatement)
  }

  func deleteBreastCancer(val : String)
  { let deleteStatementString = "DELETE FROM BreastCancer WHERE id = '" + val + "'"
    var deleteStatement: OpaquePointer?
    
    if sqlite3_prepare_v2(dbPointer, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK
    { sqlite3_step(deleteStatement) }
    sqlite3_finalize(deleteStatement)
  }


  deinit
  { sqlite3_close(self.dbPointer) }

  func setDataBreastCancer(statement: String) -> [BreastCancerVO] {
          var res : [BreastCancerVO] = [BreastCancerVO]()
          let queryStatement = try? prepareStatement(sql: statement)
          
          while (sqlite3_step(queryStatement) == SQLITE_ROW)
          { 
            let breastCancervo = BreastCancerVO()
            
	      guard let queryResultBreastCancerColId = sqlite3_column_text(queryStatement, 1)
			      else { return res }	      
			      let id = String(cString: queryResultBreastCancerColId)
			      breastCancervo.setId(x: id)
	      let queryResultBreastCancerColAge = sqlite3_column_int(queryStatement, 2)
			      let age = Int(queryResultBreastCancerColAge)
			      breastCancervo.setAge(x: age)
	      let queryResultBreastCancerColBmi = sqlite3_column_double(queryStatement, 3)
			      let bmi = Float(queryResultBreastCancerColBmi)
			      breastCancervo.setBmi(x: bmi)
	      let queryResultBreastCancerColGlucose = sqlite3_column_double(queryStatement, 4)
			      let glucose = Float(queryResultBreastCancerColGlucose)
			      breastCancervo.setGlucose(x: glucose)
	      let queryResultBreastCancerColInsulin = sqlite3_column_double(queryStatement, 5)
			      let insulin = Float(queryResultBreastCancerColInsulin)
			      breastCancervo.setInsulin(x: insulin)
	      let queryResultBreastCancerColHoma = sqlite3_column_double(queryStatement, 6)
			      let homa = Float(queryResultBreastCancerColHoma)
			      breastCancervo.setHoma(x: homa)
	      let queryResultBreastCancerColLeptin = sqlite3_column_double(queryStatement, 7)
			      let leptin = Float(queryResultBreastCancerColLeptin)
			      breastCancervo.setLeptin(x: leptin)
	      let queryResultBreastCancerColAdiponectin = sqlite3_column_double(queryStatement, 8)
			      let adiponectin = Float(queryResultBreastCancerColAdiponectin)
			      breastCancervo.setAdiponectin(x: adiponectin)
	      let queryResultBreastCancerColResistin = sqlite3_column_double(queryStatement, 9)
			      let resistin = Float(queryResultBreastCancerColResistin)
			      breastCancervo.setResistin(x: resistin)
	      let queryResultBreastCancerColMcp = sqlite3_column_double(queryStatement, 10)
			      let mcp = Float(queryResultBreastCancerColMcp)
			      breastCancervo.setMcp(x: mcp)
	      guard let queryResultBreastCancerColOutcome = sqlite3_column_text(queryStatement, 11)
			      else { return res }	      
			      let outcome = String(cString: queryResultBreastCancerColOutcome)
			      breastCancervo.setOutcome(x: outcome)
  
            res.append(breastCancervo)
          }
          sqlite3_finalize(queryStatement)
          return res
      }
      
}

