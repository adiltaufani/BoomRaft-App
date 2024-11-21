import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:flutter_project/firebase_options.dart';
import 'package:flutter_project/routes/router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebasePushHandler);

  // Memuat variabel lingkungan dari file .env
  await dot_env.dotenv.load(fileName: ".env");

  // Inisialisasi notifikasi
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notifications for basic updates',
      ),
    ],
    debug: true,
  );

  // Inisialisasi Gemini
  Gemini.init(apiKey: dot_env.dotenv.env['GEMINI_API_KEY'] ?? '');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Listen to auth state changes
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child:
                    CircularProgressIndicator(), // Show loading indicator while checking user authentication state
              ),
            ),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) => generateRoute(settings),
            home: snapshot.data == null
                ? MainScreen()
                : LoginScreen(), // Redirect to appropriate screen based on auth state
          );
        }
      },
    );
  }
}

Future<void> _firebasePushHandler(RemoteMessage message) async {
  print("Message from push notification is ${message.data}");
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}
