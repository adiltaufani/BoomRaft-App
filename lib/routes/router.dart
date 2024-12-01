import 'package:flutter/material.dart';
import 'package:flutter_project/screens/auth_screen.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:flutter_project/screens/booking_page.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/screens/otp_screen.dart';
import 'package:flutter_project/screens/waiting_payment_page.dart';
import 'package:flutter_project/zzunused/nearfromyou/screens/near_from_you.dart';
import 'package:flutter_project/screens/notification_page.dart';
import 'package:flutter_project/screens/payment_success.dart';
import 'package:flutter_project/screens/payment_page.dart';
import 'package:flutter_project/screens/transaction_screen.dart';
import 'package:flutter_project/screens/payment_gateway_screen.dart';
import 'package:flutter_project/screens/profile_setting.dart';
import 'package:flutter_project/screens/setting_page.dart';
import 'package:flutter_project/screens/reschedule_page.dart';

Widget? currentScreen;

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case BookingPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BookingPage(
          url_foto: '',
          hotel_id: '',
          latitude: '',
          longitude: '',
          sellersEmail: '',
          sellersFoto: '',
          sellersName: '',
          sellersUid: '',
          sellersid: '',
        ),
      );
    case PaymentPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PaymentPage(
          id: '',
          hotel_id: '',
          hargaTotal: '',
          startDate: '',
          url_foto: '',
          endDate: '',
          adultValue: 0,
          childValue: 0,
          sellersid: '',
          dbendDate: '',
          dbstartDate: '',
        ),
      );

    case ReschedulePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ReschedulePage(
          id: '',
          hotel_id: '',
          nama_penginapan: '',
          hargaTotal: '',
          lokasi: '',
          startDate: '',
          url_foto: '',
          endDate: '',
          tipekamar: '',
          booking_id: '',
        ),
      );

    // case LandmarkResult.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => LandmarkResult(),
    //   );

    case PaymentUi.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PaymentUi(
          uid: '',
          productName: '',
          hargaTotal: '',
          customerAddress: '',
          customerName: '',
          customerPhone: '',
          startDate: '',
          endDate: '',
        ),
      );
    case NotificationPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NotificationPage(),
      );
    case PaymentSuccess.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PaymentSuccess(
          uid: '',
          firstname: '',
          nama_penginapan: '',
          startDate: '',
          endDate: '',
        ),
      );
    case TransactionScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TransactionScreen(),
      );
    case SettingPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SettingPage(),
      );
    case WaitingPaymentPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const WaitingPaymentPage(),
      );
    case OtpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OtpScreen(),
      );
    case ProfileSetting.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfileSetting(),
      );
    case MainScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case NearFromYou.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NearFromYou(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('screen does not exist'),
          ),
        ),
      );
  }
}
