import 'package:cliver_mobile/app/features/authentication/forget_pass/forget_pass_screen.dart';
import 'package:cliver_mobile/app/features/authentication/forget_pass/verify_email_screen.dart';
import 'package:cliver_mobile/app/features/authentication/signup/screens/success_screen.dart';
import 'package:cliver_mobile/app/features/authentication/signup/screens/verify_email_signup_screen.dart';
import 'package:cliver_mobile/app/features/bottom_navigation_bar/my_bottom_bar.dart';
import 'package:cliver_mobile/app/features/buyer/save_list/save_list_detail.dart';
import 'package:cliver_mobile/app/features/buyer/save_list/save_list_screen.dart';
import 'package:cliver_mobile/app/features/buyer/search/search.dart';
import 'package:cliver_mobile/app/features/chat/screens/chat_screen.dart';
import 'package:cliver_mobile/app/features/payment/screens/budget_payment.dart';
import 'package:cliver_mobile/app/features/payment/screens/payment_method_screen.dart';
import 'package:cliver_mobile/app/features/seller/earning/earning_screen.dart';
import 'package:cliver_mobile/app/features/seller/post/screens/post/add_post/add_post_screen.dart';
import 'package:cliver_mobile/app/features/seller/post/screens/post/edit_post/edit_post_screen.dart';
import 'package:cliver_mobile/app/features/seller/post/screens/post/review_post_screen.dart';
import 'package:cliver_mobile/app/features/setting/screens/preference_screen.dart';
import 'package:cliver_mobile/app/features/user_profile/screens/buyer_profile_screen.dart';
import 'package:cliver_mobile/app/features/user_profile/screens/seller_profile.dart';
import 'package:cliver_mobile/app/routes/routes.dart';
import 'package:get/get.dart';
import '../features/authentication/login/login_screen.dart';
import '../features/authentication/signup/screens/signup_screen.dart';
import '../features/buyer/order/screens/buyer_order_detail.dart';
import '../features/seller/custom_order/custom_order_screen.dart';
import '../features/seller/post/screens/order/screens/seller_order_detail.dart';
import '../features/seller/post/screens/post/post_detail.dart';

//routes navigation
class AppPages {
  static final pages = [
    //AUTHENTICATION ROUTES
    GetPage(
        name: loginScreenRoute,
        page: () => const LoginScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: signUpScreenRoute,
        page: () => const SignUpScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: verifyEmailSignupScreenRoute,
        page: () => const VerifyEmailSignupScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: successScreenRoute,
        page: () => const SuccessScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: forgetPassScreenRoute,
        page: () => const ForgetPassScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: verifyEmailScreenRoute,
        page: () => const VerifyEmailScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: myBottomBarRoute,
        page: () => const MyBottomBar(),
        transition: Transition.fadeIn),
    GetPage(
        name: chatScreenRoute,
        page: () => const ChatScreen(),
        transition: Transition.fadeIn),
    //GetPage(name: conversationScreenRoute, page: () => const ConversationScreen(), transition: Transition.fadeIn),
    //SETTING ROUTE
    GetPage(
        name: preferencesSettingScreenRoute,
        page: () => const PreferencesSettingScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: postDetailScreenRoute,
        page: () => const PostDetailScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: postReviewScreenRoute,
        page: () => const PostReviewScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: sellerOrderDetailScreenRoute,
        page: () => const SellerOrderDetail(),
        transition: Transition.rightToLeft),
    GetPage(
        name: buyerOrderDetailScreenRoute,
        page: () => const BuyerOrderDetail(),
        transition: Transition.rightToLeft),
    GetPage(
        name: addPostScreenRoute,
        page: () => const AddPostScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: sellerProfileScreenRoute,
        page: () => const SellerProfileScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: buyerProfileScreenRoute,
        page: () => const BuyerProfileScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: earningScreenRoute,
        page: () => const EarningScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: searchRoute,
        page: () => const SearchPage(),
        transition: Transition.fade),
    GetPage(name: saveListRoute, page: () => const SaveList()),
    GetPage(
        name: saveListDetailRoute,
        page: () => const SaveListDetail(),
        transition: Transition.rightToLeft),
    GetPage(
        name: customOrderScreenRoute,
        page: () => const CustomOrderScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: paymentMethodRoute,
        page: () => const PaymentMethodScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: budgetPaymentRoute,
        page: () => const BudgetPayment(),
        transition: Transition.rightToLeft),
    GetPage(
        name: editPostScreenRoute,
        page: () => const EditPostScreen(),
        transition: Transition.rightToLeft),
  ];
}
