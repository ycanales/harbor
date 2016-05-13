import Foundation
import ObjectMapper

public final class Project: Equatable, Mappable {
  var id: Int = 0
  var uuid: String = ""
  var repositoryName: String! = ""
  var status : Build.Status = .Unknown
  var builds: [Build] = [Build]()
  var isEnabled : Bool = false

  let transformStatus = TransformOf<Build.Status, String>(
    fromJSON: Project.convertStatusFromInt,
    toJSON: { _ in "" }
  )

  public init(id: Int) {
    self.id = id
    self.uuid = NSUUID().UUIDString
  }

  // MARK: ObjectMapper - Mappable
  public init(_ map: Map) {
    isEnabled = true
  }

  public func mapping(map: Map) {
    id             <- map["id"]
    uuid           <- map["uuid"]
    repositoryName <- map["repository_name"]
    status         <- (map["builds.0.status"], transformStatus)
    builds         <- map["builds"]

  }

  private class func convertStatusFromInt(value: String?) -> Build.Status? {
    guard let unwrappedValue = value else { return nil }
    switch unwrappedValue {
    case "success":
      return .Passing
    case "error":
      return .Failing
    case "testing":
      return .Building
    default:
      return nil
    }
  }
}

public func ==(lhs: Project, rhs: Project) -> Bool {
  return lhs.id == rhs.id
}

public final class ProjectCollection: Mappable {
  var projects = [Project]()

  public init(_ map: Map) {  }

  public func mapping(map: Map) {
    projects <- map["projects"]
  }
}