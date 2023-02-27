
import SwiftUI

struct ListBreastCancerRowScreen: View {
    
    var instance : BreastCancerVO
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()

      var body: some View { 
      	ScrollView {
    VStack {
        HStack  {
          Text(String(instance.id)).bold()
          Text(String(instance.age))
          Text(String(instance.bmi))
          Text(String(instance.glucose))
          Text(String(instance.insulin))
          Text(String(instance.homa))
	    }
        HStack {
          Text(String(instance.leptin))
          Text(String(instance.adiponectin))
          Text(String(instance.resistin))
          Text(String(instance.mcp))
          Text(String(instance.outcome))
        }
}.onAppear()
          { model.setSelectedBreastCancer(x: instance) 
          }
        }
      }
    }

    struct ListBreastCancerRowScreen_Previews: PreviewProvider {
      static var previews: some View {
        ListBreastCancerRowScreen(instance: BreastCancerVO(x: BreastCancerAllInstances[0]))
      }
    }

