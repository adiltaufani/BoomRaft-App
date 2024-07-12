import 'package:flutter/material.dart';
import 'package:flutter_project/features/auth/screens/auth_screen.dart';
import 'package:flutter_project/features/auth/screens/login_screen.dart';
import 'package:flutter_project/features/landmark/screens/landmark_nav.dart';
import 'package:flutter_project/features/message/screens/message_chat_screen.dart';
import 'package:flutter_project/features/booking/screens/booking_page.dart';
import 'package:flutter_project/features/chatAI/screens/aichat_page.dart';
import 'package:flutter_project/features/home/screens/home_screen.dart';
import 'package:flutter_project/features/home/screens/near_from_you.dart';
import 'package:flutter_project/features/landmark/screens/landmark_screen.dart';
import 'package:flutter_project/features/message/screens/message_screen.dart';
import 'package:flutter_project/features/notification/screens/notification_page.dart';
import 'package:flutter_project/features/notification/screens/payment_success.dart';
import 'package:flutter_project/features/payment/screens/payment_page.dart';
import 'package:flutter_project/features/payment/screens/transaction_screen.dart';
import 'package:flutter_project/features/paymentgateway/ui/payment_ui.dart';
import 'package:flutter_project/features/profile/screens/profile_setting.dart';
import 'package:flutter_project/features/profile/screens/setting_page.dart';
import 'package:flutter_project/features/reschedule/screens/reschedule_page.dart';
import 'package:flutter_project/features/search/screens/search_page.dart';
import 'package:flutter_project/features/search/widgets/search_page_widget.dart';
import 'package:flutter_project/features/wishlist/screens/wishlist_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case LandmarkNav.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => LandmarkNav(
          lmName: '',
          latitude: '',
          longitude: '',
        ),
      );
    case BookingPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BookingPage(
          locationAddress: 'Detailed Location Address\nLocation Address',
          locationName: 'Location Name',
          jumlah_reviewer: '',
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
          nama_penginapan: '',
          hargaTotal: '',
          lokasi: '',
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

    case SearchPageWidget.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SearchPageWidget(),
      );
    case SearchPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchPage(
          namaKota: '',
        ),
      );
    // case LandmarkResult.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => LandmarkResult(),
    //   );
    case AIChatPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AIChatPage(),
      );
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
    case LandmarkScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LandmarkScreen(),
      );
    case WishlistScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const WishlistScreen(),
      );
    case MessageScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MessageScreen(),
      );
    case MessageInboxScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => MessageInboxScreen(
          receiverEmail: '',
          receiverID: '',
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
    case ProfileSetting.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfileSetting(),
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
