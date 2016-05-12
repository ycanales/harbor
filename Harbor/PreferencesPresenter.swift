import Foundation
import Cocoa

class PreferencesPresenter<V: PreferencesView> : Presenter<V> {
  //
  // MARK: Dependencies
  private let settings:           Settings
  private let projectsInteractor: ProjectsInteractor

  //
  // MARK: Properties
  private var apiKey:        String = ""
  private var refreshRate:   Double = 60.0
  private var launchOnLogin: Bool   = true
  private var allProjects:   [Project]

  private(set) var needsRefresh: Bool = true

  init(view: V, projectsInteractor: ProjectsInteractor, settings: Settings) {
    self.projectsInteractor = projectsInteractor
    self.settings = settings
    self.allProjects = [Project]()

    super.init(view: view)
  }

  //
  // MARK: Presentation Cycle
  override func didInitialize() {
    super.didInitialize()
    projectsInteractor.addListener(refreshProjects)
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    refreshIfNecessary()
  }

  override func didResignActive() {
    super.didResignActive()
    refreshIfNecessary()
  }

  func setNeedsRefresh() {
    if(!needsRefresh) {
      needsRefresh = true
    }
  }

  private func refreshIfNecessary() {
    if(needsRefresh) {
      refreshConfiguration()
      needsRefresh = false
    }
  }

  //
  // MARK: Preferences
  func savePreferences() {
    // persist our configuration
    settings.apiKey = apiKey
    settings.refreshRate = refreshRate

    // serialize the hidden projects
    settings.disabledProjectIds = allProjects.reduce([Int]()) { memo, project in
      var memo = memo

      if !project.isEnabled {
        memo.append(project.id)
      }

      return memo
    }

    needsRefresh = false
  }

  func updateApiKey(apiKey: String) {
    self.apiKey = apiKey
    setNeedsRefresh()
  }

  func updateRefreshRate(refreshRate: String) {
    self.refreshRate = (refreshRate as NSString).doubleValue
    setNeedsRefresh()
  }

  func updateLaunchOnLogin(launchOnLogin: Bool) {
    self.launchOnLogin = launchOnLogin
    setNeedsRefresh()
  }

  private func refreshConfiguration() {
    // load data from user defaults
    launchOnLogin = settings.launchOnLogin
    refreshRate   = settings.refreshRate
    apiKey        = settings.apiKey

    // update our view after refreshing
    view.updateApiKey(apiKey)
    view.updateRefreshRate(refreshRate.description)
    view.updateLaunchOnLogin(launchOnLogin)
  }

  //
  // MARK: Projects
  var numberOfProjects: Int {
    get { return allProjects.count }
  }

  func projectAtIndex(index: Int) -> Project {
    return allProjects[index];
  }

  func toggleEnabledStateForProjectAtIndex(index: Int) {
    let project = projectAtIndex(index)
    project.isEnabled = !project.isEnabled

    setNeedsRefresh()
  }

  private func refreshProjects(projects: [Project]) {
    allProjects = projects

    // notify the view that the projects refreshed
    view.updateProjects(allProjects)
  }

  //
  // MARK: Accessors
  private var defaults: NSUserDefaults {
    get { return NSUserDefaults.standardUserDefaults() }
  }
}