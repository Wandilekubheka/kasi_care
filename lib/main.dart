import 'package:clock_mate/features/home/blocs/home/files_cupit.dart';
import 'package:clock_mate/features/home/blocs/home/home_state.dart';
import 'package:clock_mate/features/home/data/models/day.dart';
import 'package:clock_mate/features/home/domain/repository/file_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clock_mate/core/blocs/user_cubit.dart';
import 'package:clock_mate/core/data/models/firebase.dart';
import 'package:clock_mate/core/theme/ktheme.dart';
import 'package:clock_mate/features/auth/data/repository/auth_repository.dart';
import 'package:clock_mate/features/auth/data/services/fireabse_auth.dart';
import 'package:clock_mate/features/auth/pages/blocs/auth_bloc.dart';
import 'package:clock_mate/features/auth/pages/screens/login_page.dart';
import 'package:clock_mate/features/home/blocs/home/home_cupit.dart';
import 'package:clock_mate/features/home/data/repository/impcalender_repository.dart';
import 'package:clock_mate/features/home/data/service/firestore.dart';
import 'package:clock_mate/features/home/data/service/local_database.dart';
import 'package:clock_mate/features/home/pages/screens/home_page.dart';
import 'package:clock_mate/firebase_options.dart';

import 'package:clock_mate/core/data/models/firebase.dart'
    show FirebaseInstance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authRepository = AuthRepository(
    FirebaseAuthService(),
    FirebaseInstance.firestoreInstance,
  );
  final datasource = ImpCalendarRepository(
    userId: FirebaseInstance.auth.currentUser?.uid ?? "",
    firestoreService: FirestoreService(
      userId: FirebaseInstance.auth.currentUser?.uid ?? "",
      firebaseFirestore: FirebaseInstance.firestoreInstance,
    ),
    localDatabase: LocalDatabase(),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(authRepository)),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => HomeCupit(datasource)),
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
      debugShowCheckedModeBanner: false,
      title: 'Clock Mate',
      theme: Ktheme.appTheme,
      home: StreamBuilder<User?>(
        stream: FirebaseInstance.auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            return BlocBuilder<HomeCupit, HomeState>(
              builder: (context, state) {
                final List<DayData> data = state is HomeMonthData
                    ? state.data
                    : [];
                return BlocProvider(
                  create: (context) => FilesCupit(FileRepository(data)),
                  child: const HomePage(),
                );
              },
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
