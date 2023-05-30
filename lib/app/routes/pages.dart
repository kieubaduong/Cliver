import 'package:get/get.dart';
import '../features/features.dart';
import 'routes.dart';

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
