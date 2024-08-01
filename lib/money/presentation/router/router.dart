import 'package:get/get.dart';
import 'package:mymoney/money/presentation/router/routes.dart';
import 'package:mymoney/money/presentation/ui/pay/pay_screen.dart';
import 'package:mymoney/money/shared/utiles/utiles.dart';

import '../di/pay_binding.dart';
import '../di/splash_Biniding.dart';
import '../di/transactionDetail_binding.dart';
import '../di/transction_binding.dart';
import '../ui/splash/splashScrean_ui.dart';
import '../ui/transaction/transaction_screen.dart';
import '../ui/transactionDetels/transactionDetails_screen.dart';



class AppRouter {
  static final List<GetPage> routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.transactions,
      page: () => const TransactionsScreen(),
      binding: TransactionsBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.pay,
      page: () => const PayScreen(),
      binding: PayBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.transactionDetails,
      page: () => const TransactionDetailsScreen(),
      binding: TransactionDetailsBinding(),
      transition: _transition(),
    ),
  ];

  static Transition? _transition() => isMobile() ? null : Transition.fadeIn;
}