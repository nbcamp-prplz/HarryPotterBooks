import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        // Main.storyboard를 지우고 MainViewController를 Key로 지정
        window.rootViewController = MainViewController()
        window.makeKeyAndVisible()

        self.window = window
    }
}
