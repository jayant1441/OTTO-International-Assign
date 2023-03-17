import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otto_international_assign/auth/business_logic/auth_page_cubit.dart';
import 'package:otto_international_assign/auth/presentation/login_screen.dart';
import 'package:otto_international_assign/auth/presentation/signup_screen.dart';
import 'package:otto_international_assign/bookmark_page/business_logic/bookmark_page_cubit.dart';
import 'package:otto_international_assign/bottom_naivgation_main.dart';
import 'package:otto_international_assign/home_page/business_logic/home_page_cubit.dart';
import 'package:otto_international_assign/home_page/presentation/home_page_index.dart';
import 'package:otto_international_assign/utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await setupLocator();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => HomePageCubit()),
        BlocProvider(create: (BuildContext context) => AuthPageCubit()),
        BlocProvider(create: (BuildContext context) => BookmarkPageCubit())
      ],
      child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser != null ? LoginScreen() : const BottomNavigationMain(),
    );
  }
}

