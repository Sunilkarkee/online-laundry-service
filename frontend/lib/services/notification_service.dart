import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// A service for handling Firebase Cloud Messaging notifications
/// and displaying them as local notifications.
class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String _androidChannelId = 'laundry_service_channel';
  static const String _androidChannelName = 'Laundry Service Notifications';
  static const String _androidChannelDescription =
      'Notifications from Laundry Service';

  /// Initializes the notification service.
  Future<void> initialize() async {
    // Request notification permissions on iOS.
    if (Platform.isIOS) {
      await _messaging.requestPermission(alert: true, badge: true, sound: true);
    }

    // Initialize local notifications with platform-specific settings.
    final InitializationSettings initializationSettings =
        _buildInitializationSettings();

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Handle FCM messages when the app is in the foreground.
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Retrieve the FCM token.
    try {
      String? token = await _messaging.getToken();
      if (kDebugMode) {
        print("FCM Token: $token");
      }
      // TODO: Save token to Firestore or your backend if necessary.
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching FCM token: $e");
      }
    }
  }

  /// Builds and returns the initialization settings for local notifications.
  InitializationSettings _buildInitializationSettings() {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    return const InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );
  }

  /// Callback for when a local notification is tapped.
  void _onNotificationTap(NotificationResponse response) {
    if (kDebugMode) {
      print("Notification tapped: ${response.payload}");
    }
    // Example: Navigate to order details screen using your navigation service.
    // NavigationService.instance.navigateTo('/orderDetails/${response.payload}');
  }

  /// Handles incoming foreground FCM messages by showing a local notification.
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print("Foreground message received: ${message.notification?.title}");
    }
    await _showLocalNotification(
      id: message.hashCode,
      title: message.notification?.title ?? 'New notification',
      body: message.notification?.body ?? '',
      payload: message.data['orderId'],
    );
  }

  /// Displays a local notification.
  Future<void> _showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          _androidChannelId,
          _androidChannelName,
          channelDescription: _androidChannelDescription,
          importance: Importance.max,
          priority: Priority.high,
        );
    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Subscribes to an FCM topic.
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  /// Unsubscribes from an FCM topic.
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }
}
