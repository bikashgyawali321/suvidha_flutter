import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suvidha/main.dart';
import 'package:suvidha/models/notification_model.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/services/custom_hive.dart';
import 'package:suvidha/widgets/custom_button.dart';
import 'package:suvidha/widgets/form_bottom_sheet_header.dart';

FirebaseMessaging _messaging = FirebaseMessaging.instance;

class NotificationService extends ChangeNotifier {
  late NotificationSettings? _settings;

  BackendService backendService;

  NotificationService(this.backendService);
  final CustomHive _customHive = CustomHive();

  bool get canAskPermission =>
      _settings?.authorizationStatus == AuthorizationStatus.notDetermined ||
      _settings?.authorizationStatus == AuthorizationStatus.denied;
  bool get isNotificationEnabled => [
        AuthorizationStatus.authorized,
        AuthorizationStatus.provisional,
      ].contains(
        _settings?.authorizationStatus,
      );

  Future<void> initilize() async {
    final isSupported = await _messaging.isSupported();
    if (!isSupported) return;
    _settings = await _messaging.getNotificationSettings();
    FirebaseMessaging.onMessage.listen(_handleForegroundNotifications);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundNotifications);

    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotifications(initialMessage);
    }

    notifyListeners();
  }

  Future<void> requestPermission() async {
    _settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (_settings?.authorizationStatus == AuthorizationStatus.authorized) {
      sendFCMToken();
    }

    notifyListeners();
  }

  Future<void> sendFCMToken() async {
    final isSupported = await _messaging.isSupported();
    if (!isSupported) return;
    if (!isNotificationEnabled) return;

    final token = await _messaging.getToken();
    if (token == null) return;

    if (_customHive.getFCMToken() == token) return;

    final resp = await backendService.addFcmToken(fcmToken: token);
    if (resp.statusCode == 200) {
      await _customHive.saveFCMToken(token);
    }
  }

  void _handleForegroundNotifications(RemoteMessage message) async {
    if (message.data.isNotEmpty) {
      await _customHive.saveNotifications(
        NotificationModel(
          orderId: message.data['orderId'],
          data:
              message.notification?.body ?? 'You have an update on your order',
          date: DateTime.now(),
          title: message.notification?.title ?? 'Order Update',
          isRead: true,
        ),
      );
      _handleShowNotificationDialog(message);
    }
  }

  void _handleBackgroundNotifications(RemoteMessage message) {
    final notification = NotificationModel(
      orderId: message.data['orderId'],
      data: message.notification?.body ?? 'You have an update on your order',
      date: DateTime.now(),
      title: message.notification?.title ?? 'Order Update',
      isRead: false,
    );
    _customHive.saveNotifications(notification);
    _handleNotifications(message);
  }

  void _handleNotifications(RemoteMessage message) {
    final String? orderId = message.data['orderId'];

    if (orderId != null && navigatorKey.currentContext != null) {
      GoRouter.of(navigatorKey.currentContext!).go(
        '/order/$orderId',
      );
    }
  }

  void _handleShowNotificationDialog(RemoteMessage message) {
    showModalBottomSheet(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  FormBottomSheetHeader(
                    title: message.notification?.title ?? 'Notification',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    message.notification?.body ?? 'Update on your order status',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      label: 'Ok',
                      onPressed: () => navigatorKey.currentState!.pop(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
