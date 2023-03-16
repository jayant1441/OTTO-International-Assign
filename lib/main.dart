import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otto_international_assign/home_page/business_logic/home_page_cubit.dart';
import 'package:otto_international_assign/home_page/presentation/home_page_index.dart';
import 'package:otto_international_assign/utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => HomePageCubit())
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
      home:  const MyHomePage(),
    );
  }
}

