import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_care/core/blocs/user_cubit.dart';
import 'package:kasi_care/core/data/models/firebase.dart';
import 'package:kasi_care/core/theme/ktheme.dart';
import 'package:kasi_care/core/theme/widgets/app_tabbar.dart';
import 'package:kasi_care/features/auth/data/repository/auth_repository.dart';
import 'package:kasi_care/features/auth/data/services/fireabse_auth.dart';
import 'package:kasi_care/features/auth/pages/blocs/auth_bloc.dart';
import 'package:kasi_care/features/auth/pages/screens/login_page.dart';
import 'package:kasi_care/features/home/pages/screens/home_page.dart';
import 'package:kasi_care/firebase_options.dart';

import 'package:kasi_care/core/data/models/firebase.dart' show FirebaseInstance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authRepository = AuthRepository(
    FirebaseAuthService(),
    FirebaseInstance.firestoreInstance,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(authRepository)),
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kasi Care",
      theme: Ktheme.appTheme,
      home: StreamBuilder<User?>(
        stream: FirebaseInstance.auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
