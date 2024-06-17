import 'package:get/get.dart';
import 'package:sampark/Pages/Auth/auth_page.dart';
import 'package:sampark/Pages/Contact/contact_page.dart';
import 'package:sampark/Pages/Home/home_page.dart';
import 'package:sampark/Pages/Welcome/welcome_page.dart';


var pagePath = [
  GetPage(
    name: "/authPage", 
    page: () => const AuthPage(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: "/homePage", 
    page: () => const HomePage(),
    transition: Transition.leftToRight,
  ),

  // GetPage(
  //   name: "/chatPage",
  //   page: () => const ChatPage(),
  //   transition: Transition.leftToRight,
  // ),

  GetPage(
    name: "/welcomePage", 
    page: () => const WelcomePage(),
    transition: Transition.leftToRight,
  ),
  // GetPage(
  //   name: "/profilePage",
  //   page: () => const UserProfilePage(),
  //   transition: Transition.leftToRight,
  // ),
  GetPage(
    name: "/contactPage",
    page: () => const ContactPage(),
    transition: Transition.leftToRight,
  ),
  // GetPage(
  //   name: "/updateProfilePage",
  //   page: () => const UpdateProfile(),
  //   transition: Transition.leftToRight,
  // ),
];
