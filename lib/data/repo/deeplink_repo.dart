import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rxdart/rxdart.dart';

//Example url:
// app://albums.com/contactinfo?firstname=john&lastname=snow);
// app://albums.com/albuminfo?albumid=1);

class DeepLinkRepo {
  Subject<Uri> deepLinkUri;

  DeepLinkRepo(this.deepLinkUri);

  void setUri() {
    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      deepLinkUri.add(
        Uri.parse(openedResult.notification.payload.launchUrl ?? ""),
      );
    });
  }

  Stream<Uri> getUri() {
    setUri();
    return deepLinkUri;
  }

  Stream<DeepLinkResult> getDeepLinkResult() {
    return deepLinkUri.map((uri) {
      DeepLinkAction action = _getActionFromUri(uri);
      Map<String, String> screenData = uri.queryParameters;
      return DeepLinkResult(
        action,
        value: screenData,
      );
    });
  }

  DeepLinkAction _getActionFromUri(Uri uri) {
    switch (uri.pathSegments.last) {
      case 'home':
        return DeepLinkAction.openHome;
        break;
      case 'albumdetails':
        return DeepLinkAction.openAlbumDetails;
        break;
      case 'photos':
        return DeepLinkAction.openPhotos;
        break;
      case 'notifications':
        return DeepLinkAction.openNotifications;
        break;
      case 'contactinfo':
        return DeepLinkAction.openContactInfo;
        break;
      default:
        return DeepLinkAction.openHome;
        break;
    }
  }
}

class DeepLinkResult {
  final DeepLinkAction action;
  final Map<String, String> value;

  DeepLinkResult(
    this.action, {
    this.value,
  });
}

enum DeepLinkAction {
  openHome,
  openAlbumDetails,
  openPhotos,
  openContactInfo,
  openNotifications,
}
