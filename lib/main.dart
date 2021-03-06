import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwdmgr/providers/MasterPasswordProvider.dart';
import 'package:pwdmgr/providers/UserProvider.dart';
import 'package:pwdmgr/routes.dart';
import 'package:pwdmgr/screens/SplashScreen.dart';
import 'package:pwdmgr/services/NavigationService.dart';
import 'package:get_it/get_it.dart';
import 'package:pwdmgr/utils/Styles.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

GetIt getIt = GetIt.instance;
GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => MasterPasswordProvider()),
  ], child: MyApp()));
}

void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerLazySingleton(() => UserProvider());
  getIt.registerLazySingleton(() => MasterPasswordProvider());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PWD Manager',
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      navigatorKey: getIt.get<NavigationService>().navigatorKey,
      onGenerateRoute: routerMethod,
      initialRoute: SplashScreen.routeName,
      color: Style.PRIMARY_COLOR,
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }
}
