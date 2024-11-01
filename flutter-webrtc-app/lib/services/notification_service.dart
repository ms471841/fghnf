import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      // provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      // Handle foreground messages
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      // Handle when the app is opened from a notification
    });
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  Future<String?> getAccessToken() async {
    try {
      final serviceAccountJson = {
        "type": "service_account",
        "project_id": "video-call-demo-a639d",
        "private_key_id": "a3bbcccf715507742518835839389b141067f68a",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCzVR+hGtD6jvuc\n5LO5/Pq35A5mWgTbkbQ4IdBepB84a1MKfMxbh7iqj4BdFtJGjvkXepS0Lt7sxtc9\nYk+YIZv58MX6pgGfE1JtiyRl67mhkBTRgf0nbbBtEtkx1mwFNK+Vt1W1ywkmvqXU\nxEP+ZjqgOyXxsDIRVEkDUXFN/mEJV68OmHnPcmBMOipO96CJtswhgxfhExFCiyyj\nSMLyi9uwkQLIcV3+AVxB9tppIvy3lKvM7MzSiMqLdLmWOEo0LeSj2E5qSHlqYxwu\nWKnSjjZ1eeOJkSSQyXjyiPWJEaYSe8wXJPBkhxnpeA+hpyrxJEuF8CyMM7qWXgxH\n2Di5SLWtAgMBAAECggEAU20OQcxP28AYnWxnj+Z4XIPjjwnhqKOny1Uvsld3jq+e\n+goEp7AD4JTRinzLZbeteZa1Bv2nB0+ZYh0SGhvIjAXOlEQWDQLYHc3VKPT4boiw\npqZqNqV4pcVW9TBjICjaZjPb066Ym0Wlr81+NCMqss/RXxYwtI8ZSEnjA/2K9uTk\nTSjZ6Ee19cu+wlmt8rX5Vopu6sL0P73/qu0PflR2kRrW/y5+6zlu/hYgWIYxuEJN\nVZZN50k2RPGHkrA5ltGEt1Vdxty5GNHDRjePcQOtGS5ZYm8iAz/IgC8uGKhqAnF+\nC22HT+Xf0PlMVnGdQVGEGcel8I/S558VN4HuGKJ+oQKBgQDax9blBL7S4AevWXTu\nInSNotur91GrmYR12+V0OvjuLohdN6wdneOjI+amOkQrWnEfK7F0CLjwcd2hVddv\noa5ih4tsOub4HiuLMVg3WP76W2uU/qQri+rH0yraGUwjvdxMpJ2yXL+hTx5ecM0a\nbuSjW0xMKJW7FG2shYQw9bmLAwKBgQDR10VzmS46FKe6UfAwHbzNeGAJdanCmzyX\nq2digUOfEbUDqMXOB+np0pV9ezE4sLyXg08RERdHRe09svqUP8fkYQB2vQega38B\nTadk5p+1T1zyLAEnniVT0XLPqm1Ji2hYCsgb/qrKS9CLpIrnCa6D/9Gf1UtYUPPT\nlC/X+08FjwKBgEPzW6BICAixAlIJA9NOqkqvcXEI4LnedZCxmqOuCVDY7Que1ftg\n5anu5Z1tbWzVq1rWFEiIyQANLZwFcGNAoUwC81/LL5+Sp02VJuQR5SfXKyPcrxrD\nW0lzIdUZlFdpibnYSw5x1icAztrgSCPUm3jNS3ZACLlRT/sMgRE/0MAHAoGAEJUd\ndOwm/goB0zSEcZj4AZjAph65Qpq36BhwfBVQ/bINhvOAZi6z6nlsvNTOZ/d3f9Wt\nmuCp4UUCYXzSVoLPzhloSvnXL3MvPzAeyVd8SXyzEKQvlyzlMEF9/DEwn743ibWY\naLXwUzo4icCABY/7TY0ayLG3WYxUKGUufrfqX7sCgYEAlrAWNU4XcWxpqDgSaAGi\n/14Hmy4iFTLDoQ80nIZGEVY7XCqFKpSfDDEEg70OClzmwmwvtVPirVNr0/f63HHW\nJu8uyiTeN9XZtBe3KwnMeDSLff8ewzHyrezwWojaKMiodL4u+8C64wSjauH8CELw\nsIu97QSLFTyW4C5ug34LbWo=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-bw2wk@video-call-demo-a639d.iam.gserviceaccount.com",
        "client_id": "100758996307673922960",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-bw2wk%40video-call-demo-a639d.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      };
      List<String> scopes = [
        "https://www.googleapis.com/auth/firebase.database",
        "https://www.googleapis.com/auth/firebase.messaging",
        "https://www.googleapis.com/auth/userinfo.email"
      ];
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);
      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
              scopes,
              client);
      client.close();
      return credentials.accessToken.data;
    } catch (e) {
      //
      rethrow;
    }
  }

  Future<void> sendNotification() async {
    try {
      final accessToken = await getAccessToken();
      final fcmToken = await getToken();
      log(accessToken.toString());
      final res = await http.post(
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/myproject-video-call-demo-a639d/messages:send'),
          body: jsonEncode({
            "message": {
              "token": fcmToken,
              "notification": {
                "title": "Portugal vs. Denmark",
                "body": "great match!"
              },
              "data": {"Nick": "Mario", "Room": "PortugalVSDenmark"}
            }
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer a3bbcccf715507742518835839389b141067f68a'
          });
      log(res.body.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
