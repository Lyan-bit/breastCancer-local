              
              
import SwiftUI

@main 
struct breastcancerMain : App {

	var body: some Scene {
	        WindowGroup {
	            ContentView(model: ModelFacade.getInstance())
	        }
	    }
	} 
