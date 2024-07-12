import 'package:flutter/material.dart';
import 'package:flutter_project/features/notification/screens/payment_success.dart';
import 'package:flutter_project/features/paymentgateway/services/token_service.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:flutter_project/features/paymentgateway/model/product_model.dart';

class PaymentUi extends StatefulWidget {
  static const String routeName = '/payment-ui';
  final String uid;
  final String productName;
  final String hargaTotal;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String startDate;
  final String endDate;

  PaymentUi({
    required this.uid,
    required this.productName,
    required this.hargaTotal,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<PaymentUi> createState() => _PaymentUiState();
}

class _PaymentUiState extends State<PaymentUi> {
  late final MidtransSDK? _midtrans;

  @override
  void initState() {
    super.initState();
    _initSDK();
  }

  void _initSDK() async {
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: dot_env.dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "",
        merchantBaseUrl: "",
        colorTheme: ColorTheme(
          colorPrimary: Colors.blue,
          colorPrimaryDark: Colors.blue,
          colorSecondary: Colors.blue,
        ),
      ),
    );
    _midtrans?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );
    _midtrans!.setTransactionFinishedCallback((result) {
      _showSnackBar('Transaction Completed', false);
      _navigateToSuccessPage(); // Navigate to the success page
    });

    startPayment();
  }

  void _showSnackBar(String msg, bool isError) {
    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _navigateToSuccessPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentSuccess(
                uid: widget.uid,
                firstname: widget.customerName,
                nama_penginapan: widget.productName,
                startDate: widget.startDate,
                endDate: widget.endDate,
              )),
    );
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  void startPayment() async {
    String harga = widget.hargaTotal;
    double? price;
    try {
      price = double.parse(harga);
    } catch (e) {
      print('Error parsing price: $e');
      _showSnackBar('Invalid price format', true);
      return;
    }

    // Create a product with the required data
    final product = Product(
      productName: widget.productName,
      price: price,
      quantity: 1,
      customerName: widget.customerName,
      customerPhone: widget.customerPhone,
      customerAddress: widget.customerAddress,
    );

    final result = await TokenService().getToken();

    if (result.isRight()) {
      String? token = result.fold((l) => null, (r) => r.token);

      if (token != null) {
        _midtrans?.startPaymentUiFlow(
          token: token,
        );
      }
    } else {
      _showSnackBar('Transaction Failed', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
      ),
      home: Scaffold(
        body: Center(
          child: Text('Processing data ...'),
        ),
      ),
    );
  }
}
