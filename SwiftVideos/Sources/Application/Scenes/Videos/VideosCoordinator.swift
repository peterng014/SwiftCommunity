//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift

class VideosCoordinator: NavigationCoordinator<VideosRoute> {

    // MARK: Properties

    // Private

    private let component: VideosComponent

    // MARK: Initialization

    init(initialRoute: VideosRoute, depedency: VideosDependency, context: ApplicationContext) {
        component = VideosComponent(dependency: depedency, context: context)
        super.init(initialRoute: initialRoute)
    }

    // MARK: Overrides

    override func prepareTransition(for route: VideosRoute) -> NavigationTransition {
        switch route {
        case .videos(let conferenceMetaData, let conferenceEdition):
            let viewController = component.makeVideosCollectionViewController(conferenceMetaData: conferenceMetaData, conferenceEdition: conferenceEdition, router: anyRouter)
            return .push(viewController)

        case .videoDetail(let videoMetaData, let hasLeftCloseButton):
            let viewController = component.makeVideoDetailViewController(videoMetaData: videoMetaData, hasLeftCloseButton: hasLeftCloseButton, router: anyRouter)
            return .push(viewController)

        case .videoPlayer(let videoMetaData):
            let viewController = component.makeVideoPlayerViewController(videoMetaData: videoMetaData)
            return .push(viewController)

        case .close:
            return .dismissToRoot()
        }
    }

}

public enum VideosRoute: Route {
    case videos(ConferenceMetaData?, ConferenceEdition?)
    case videoDetail(VideoMetaData, Bool)
    case videoPlayer(VideoMetaData)
    case close
}
