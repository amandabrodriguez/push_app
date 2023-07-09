import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage remote) async {
  await Firebase.initializeApp();
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationsStatusChanged>(_notificationStatusChanged);
    _initialStatusCheck();
    _onForegroundMessage();
  }

  static Future<void> initializeFirebaseNotifications() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(
    NotificationsStatusChanged event,
    Emitter<NotificationsState> emit,
  ) {
    emit(
      state.copyWith(
        status: event.status,
      ),
    );
    _getFCMToken();
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationsStatusChanged(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();
    print(token);
  }

  void requestPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    add(NotificationsStatusChanged(settings.authorizationStatus));
  }

  void _handleRemoteMessage(RemoteMessage message) {
    print('Foreground');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Notification: ${message.notification}');
    }
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }
}
