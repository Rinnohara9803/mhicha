import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mhicha/pages/dashboard_page.dart';
import 'package:mhicha/pages/edit_profile_page.dart';
import 'package:mhicha/pages/load_money_page.dart';
import 'package:mhicha/pages/proceed_send_money_page.dart';
import 'package:mhicha/pages/profile_page.dart';
import 'package:mhicha/pages/qr_page.dart';
import 'package:mhicha/pages/send_money_page.dart';
import 'package:mhicha/pages/send_money_success_page.dart';
import 'package:mhicha/pages/splash_page.dart';
import 'package:mhicha/pages/verify_email_page.dart';
import 'package:mhicha/pages/sign_in_page.dart';
import 'package:mhicha/pages/sign_up_page.dart';
import 'package:mhicha/pages/verify_loadmoneyotp_page.dart';
import 'package:mhicha/providers/locale_provider.dart';
import 'package:mhicha/providers/profile_provider.dart';
import 'package:mhicha/providers/theme_provider.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'L10n/L10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'high_importance_notification',
  description: 'this channel is used for important notifications',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LocaleProvider>(
          create: (context) => LocaleProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).isDarkMode
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Colors.white,
              ),
            )
          : ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: ThemeClass.primaryColor,
              ),
            ),
      home: const SplashPage(),
      routes: {
        SignInPage.routeName: (context) => const SignInPage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        VerifyEmailPage.routeName: (context) => const VerifyEmailPage(),
        DashboardPage.routeName: (context) => const DashboardPage(),
        QRPage.routeName: (context) => const QRPage(),
        SendMoneyPage.routeName: (context) => const SendMoneyPage(),
        ProceedSendMoneyPage.routeName: (context) =>
            const ProceedSendMoneyPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        EditProfilePage.routeName: (context) => const EditProfilePage(),
        SendMoneySuccessPage.routeName: (context) =>
            const SendMoneySuccessPage(),
        LoadMoneyPage.routeName: (context) => const LoadMoneyPage(),
        VerifyLoadMoneyOtpPage.routeName: (context) =>
            const VerifyLoadMoneyOtpPage(),
      },
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: Provider.of<LocaleProvider>(context).locale,
    );
  }
}
