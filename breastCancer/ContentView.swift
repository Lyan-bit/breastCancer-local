              
              
              
import SwiftUI

struct ContentView : View {
	
	@ObservedObject var model : ModelFacade
	                                       
	var body: some View {
		TabView {
            CreateBreastCancerScreen (model: model).tabItem { 
                        Image(systemName: "1.square.fill")
	                    Text("+BreastCancer")} 
            ListBreastCancerScreen (model: model).tabItem { 
                        Image(systemName: "2.square.fill")
	                    Text("ListBreastCancer")} 
            ClassifyBreastCancerScreen (model: model).tabItem { 
                        Image(systemName: "3.square.fill")
	                    Text("ClassifyBreastCancer")} 
				}.font(.headline)
		}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ModelFacade.getInstance())
    }
}

