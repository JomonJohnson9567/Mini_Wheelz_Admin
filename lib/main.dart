import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_cubit.dart';
import 'package:mini_wheelz/presentation/auth/signin/pages/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mini Wheelz',
        theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
        home: SignUpScreen(),
      ),
    );
  }
}
