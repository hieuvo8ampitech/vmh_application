import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vmh_application/app/helpers/theme.dart';
import 'package:vmh_application/app/helpers/util.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // Ensure that Flutter bindings are initialized before using GetX or Supabase
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: 'https://rldtwrtcsqwsluxffwoe.supabase.co',
    anonKey: dotenv.env['apiKey'] ?? '',
    authOptions: const FlutterAuthClientOptions(autoRefreshToken: true),
  );

  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;
    final Session? session = data.session;

    if (event == AuthChangeEvent.signedOut) {
      debugPrint('User signed out');
      // User signed out
      Get.offAllNamed('/login'); // Navigate to login if signed out
    } else if (event == AuthChangeEvent.tokenRefreshed) {
      debugPrint('Token refreshed');
      // Token refreshed
      if (session != null) {
        Get.offAllNamed('/home'); // Navigate to home if session is valid
      }
    } else if (event == AuthChangeEvent.signedIn) {
      debugPrint('User signed in');
      // User signed in
      if (session != null) {
        Get.offAllNamed('/home'); // Navigate to home if session is valid
      }
    } else if (event == AuthChangeEvent.userUpdated && session == null) {
      debugPrint('User updated without a session');
      // Session expired or user updated without a session
      Get.offAllNamed('/login'); // Navigate to login if session is null
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Asap", "Asap");
    MaterialTheme theme = MaterialTheme(textTheme);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "VMH Application",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: Get.isDarkMode ? theme.dark() : theme.light(),
    );
  }
}
