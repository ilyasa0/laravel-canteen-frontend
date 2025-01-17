import 'package:canteen_app/data/dataresource/auth_local.dart';
import 'package:canteen_app/data/dataresource/auth_remote.dart';
import 'package:canteen_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:canteen_app/presentation/general/dashboard_page.dart';
import 'package:canteen_app/presentation/general/splash_page.dart';
import 'package:canteen_app/presentation/home/bloc/logout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: GoogleFonts
              .poppins()
              .fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
          future: AuthLocal().isAuth(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return const DashboardPage();
            } else {
              return const SplashPage();
            }
          },
        ),
      ),
    );
  }
}
