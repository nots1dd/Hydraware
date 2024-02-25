import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hydraware/pages/forgotpwdpage.dart';
import 'package:hydraware/pages/auth/authpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hydraware/pages/introduction_screen.dart';
import 'package:hydraware/pages/search_screens/chat_screen.dart';
import 'package:hydraware/pages/search_screens/posts/post_screen.dart';
import 'package:hydraware/pages/search_screens/search_announcements.dart';
import 'package:hydraware/pages/searchscreen.dart';
import 'package:hydraware/pages/settings_screen.dart';
import 'package:hydraware/pages/settings_screens/license.dart';
import 'package:hydraware/pages/settings_screens/privacy_policy.dart';
import 'package:hydraware/pages/settings_screens/profile.dart';
import 'package:hydraware/pages/settings_screens/theme.dart';
import 'package:hydraware/pages/settings_screens/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  Gemini.init(apiKey: dotenv.env['GEMINI_API_KEY_2']!);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/privacy': (BuildContext context) => const PrivacyPolicy(),
        '/license': (BuildContext context) => const License(),
        '/theme': (BuildContext context) => const ThemePage(),
        '/settings': (BuildContext context) => SettingsScreen(),
        '/profile': (BuildContext context) => Profile(),
        '/login': (BuildContext context) => const AuthPage(),
        '/chat': (BuildContext context) => const ChatScreen(),
        '/forgotpwd': (BuildContext context) => const ForgotPwd(),
        '/search': (BuildContext context) => const SearchScreen(),
        '/announcement': (BuildContext context) => const SearchAnnouncements(),
        '/post': (BuildContext context) => PostScreen(),
      },
      theme: Provider.of<ThemeProvider>(context).getTheme,
      debugShowCheckedModeBanner: false,
      home: const IntroScreen(),
    );
  }
}
