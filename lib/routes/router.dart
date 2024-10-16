import 'package:flutter/material.dart';
import 'package:flutter_project/screens/auth_screen.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/zzunused/message/screens/message_chat_screen.dart';
import 'package:flutter_project/screens/booking_page.dart';
import 'package:flutter_project/zzunused/chatAI/screens/aichat_page.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/zzunused/nearfromyou/screens/near_from_you.dart';
import 'package:flutter_project/zzunused/message/screens/message_screen.dart';
import 'package:flutter_project/screens/notification_page.dart';
import 'package:flutter_project/screens/payment_success.dart';
import 'package:flutter_project/screens/payment_page.dart';
import 'package:flutter_project/screens/transaction_screen.dart';
import 'package:flutter_project/screens/payment_gateway_screen.dart';
import 'package:flutter_project/screens/profile_setting.dart';
import 'package:flutter_project/screens/setting_page.dart';
import 'package:flutter_project/screens/reschedule_page.dart';
import 'package:flutter_project/zzunused/search/screens/search_page.dart';
import 'package:flutter_project/zzunused/search/widgets/search_page_widget.dart';
import 'package:flutter_project/zzunused/wishlist/screens/wishlist_screen.dart';

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
