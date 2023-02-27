
import SwiftUI

struct ListBreastCancerScreen: View {
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()

     var body: some View
     { List(model.currentBreastCancers){ instance in 
     	ListBreastCancerRowScreen(instance: instance) }
       .onAppear(perform: { model.listBreastCancer() })
     }
    
}

struct ListBreastCancerScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListBreastCancerScreen(model: ModelFacade.getInstance())
    }
}

