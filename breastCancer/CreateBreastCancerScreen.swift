
import SwiftUI

struct CreateBreastCancerScreen: View {
 
  @State var bean : BreastCancerVO = BreastCancerVO()
  @ObservedObject var model : ModelFacade

  var body: some View {
  	NavigationView {
  		ScrollView {
  	VStack(spacing: 20) {

  VStack(spacing: 20) {
		HStack (spacing: 20) {
		 Text("Id:").bold()
		 TextField("Id", text: $bean.id).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Age:").bold()
		TextField("Age", value: $bean.age, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Bmi:").bold()
		TextField("Bmi", value: $bean.bmi, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Glucose:").bold()
		TextField("Glucose", value: $bean.glucose, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Insulin:").bold()
		TextField("Insulin", value: $bean.insulin, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Homa:").bold()
		TextField("Homa", value: $bean.homa, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

	}
	VStack(spacing: 20) {
		HStack (spacing: 20) {
		 Text("Leptin:").bold()
		 TextField("Leptin", value: $bean.leptin, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
		 }.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		 Text("Adiponectin:").bold()
		 TextField("Adiponectin", value: $bean.adiponectin, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
		 }.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		 Text("Resistin:").bold()
		 TextField("Resistin", value: $bean.resistin, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
		 }.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		 Text("Mcp:").bold()
		 TextField("Mcp", value: $bean.mcp, format: .number).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
		 }.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20)  {
		  Text("Outcome:").bold()
		  TextField("Outcome", text: $bean.outcome).textFieldStyle(RoundedBorderTextFieldStyle())
		  }.frame(width: 200, height: 30).border(Color.gray)

}

      HStack(spacing: 20) {
        Button(action: { 
        	self.model.createBreastCancer(x: bean)
        } ) { Text("Create") }
        Button(action: { self.model.cancelCreateBreastCancer() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top)
     }.navigationTitle("Create BreastCancer")
    }
  }
}

struct CreateBreastCancerScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateBreastCancerScreen(model: ModelFacade.getInstance())
    }
}

