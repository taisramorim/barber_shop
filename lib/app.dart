import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barber_shop/app_view.dart';
import 'package:barber_shop/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MainApp extends StatelessWidget {
  final UserRepository userRepository;

  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>
        (create: (_) => AuthenticationBloc(
          myUserRepository: userRepository),)
      ], 
      child: const MyAppView()
      );
  }
}