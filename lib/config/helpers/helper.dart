import 'package:firebase_messaging/firebase_messaging.dart';

class Helper {
  String cleanMessageId(RemoteMessage message) {
    return message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '';
  }
}
