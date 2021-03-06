//@testable import Harbor
//
//import Quick
//import Nimble
//import Drip
//
//class SettingsSpec: HarborSpec {
//  override func spec() {
//    super.spec()
//
//    var example: Example<SettingsType>!
//
//    beforeEach {
//      example = Example { ex in
//        ex.app
//          .override(ex.keychain as Keychain)
//          .override(ex.defaults as UserDefaults)
//          .override(ex.notificationCenter as NotificationCenter)
//
//        return ex.app.interactor.inject()
//      }
//    }
//
//    describe("the initializer"){
//      it("retrieves the correct API Key") {
//        let apiKey = "12903jasjfd0aj21"
//        example.subject.apiKey = apiKey
//
//        let local = example.rebuild { $0.keychain = example.keychain }
//        expect(local.subject.apiKey).to(equal(apiKey))
//      }
//
//      it("retrieves the correct refresh rate"){
//        let refreshRate = 90
//        example.subject.refreshRate = refreshRate
//
//        let local = example.rebuild { $0.defaults = example.defaults }
//        expect(local.subject.refreshRate).to(equal(refreshRate))
//      }
//      
//      it("provides a default refresh rate if it has not been set"){
//        let refreshRate = 60
//        
//        let local = example.rebuild { $0.defaults = example.defaults }
//        expect(local.subject.refreshRate).to(equal(refreshRate))
//      }
//
//      it("retrieves the correct disabled project ids"){
//        let disabledProjectIds = [1, 2, 3, 4]
//        example.subject.disabledProjectIds = disabledProjectIds
//
//        let local = example.rebuild { $0.defaults = example.defaults }
//        expect(local.subject.disabledProjectIds).to(equal(disabledProjectIds))
//      }
//    }
//
//    describe("setting") {
//      describe("the refresh rate") {
//        let value = 60
//
//        it("updates user defaults with the given rate"){
//          let invocation = Invocations.defaults(.SetInteger, VerifierOf(value))
//
//          example.subject.refreshRate = value
//          expect(example.defaults.invocation).to(match(invocation))
//        }
//
//        it("posts a notification") {
//          let invocation = Invocations.notification(.PostNotificationName, .RefreshRate)
//          example.subject.refreshRate = value
//          expect(example.notificationCenter.invocation).to(match(invocation))
//        }
//      }
//
//      describe("the API key") {
//        let apiKey = "9900alk00sd52fjsadlkjfsal"
//
//        it("sets the API Key in the keychain"){
//          let invocation = Invocations.keychain(.SetString, VerifierOf(apiKey))
//
//          example.subject.apiKey = apiKey
//          expect(example.keychain.invocation).to(match(invocation))
//        }
//
//        it("posts a notification") {
//          let invocation = Invocations.notification(.PostNotificationName, .ApiKey)
//
//          example.subject.apiKey = apiKey
//          expect(example.notificationCenter.invocation).to(match(invocation))
//        }
//      }
//
//      describe("the disabled projects array") {
//        let disabledProjectIds = [3, 17, 23, 50]
//
//        it("sends user defaults the disabled project id array"){
//          let invocation = Invocations.defaults(.SetObject, VerifierOf(disabledProjectIds))
//
//          example.subject.disabledProjectIds = disabledProjectIds
//          expect(example.defaults.invocation).to(match(invocation))
//        }
//
//        it("posts a notification") {
//          let invocation = Invocations.notification(.PostNotificationName, .DisabledProjects)
//
//          example.subject.disabledProjectIds = disabledProjectIds
//          expect(example.notificationCenter.invocation).to(match(invocation))
//        }
//      }
//    }
//
//    describe("notification extension") {
//      describe("observeNotification") {
//        it("should add an observer to notification center") {
//          let notification = SettingsNotification.ApiKey
//          let invocation   = Invocations.notification(.AddObserverForName, notification)
//
//          example.subject.observeNotification(notification, handler: { _ in })
//          expect(example.notificationCenter.invocation).to(match(invocation))
//        }
//      }
//    }
//  }
//}
