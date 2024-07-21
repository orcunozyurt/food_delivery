import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'screens/auth/views/welcome_screen.dart';
import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade200,
          onSurface: Colors.black,
          primary: Colors.blue,
          onPrimary: Colors.white,
          secondary: Colors.blueAccent,
        )
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return BlocProvider(
                create: (context) => SignInBloc(
                  context.read<AuthenticationBloc>().userRepository,
                ),
                child: HomeScreen()
            );
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
