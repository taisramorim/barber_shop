import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barber_shop/screens/authentication/sign_in_page.dart';
import 'package:barber_shop/screens/authentication/sign_up_page.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
	late TabController tabController;

	@override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Theme.of(context).colorScheme.surface,
			body: SingleChildScrollView(
				child: SizedBox(
					height: MediaQuery.of(context).size.height,
					child: Padding(
						padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
						child: Column(
							children: [
                                  // LOGO
								Image.network('https://firebasestorage.googleapis.com/v0/b/testing-ozt.appspot.com/o/icone.png?alt=media&token=cf61553b-eb76-4f9e-86dc-ba020c1bc6b4',
                  width: 100,
                  height: 100
                ),
								const SizedBox(height: kToolbarHeight),
								TabBar(
									controller: tabController,
									unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
									labelColor: Theme.of(context).colorScheme.onSurface,
									tabs: const [
										Padding(
											padding: EdgeInsets.all(12.0),
											child: Text(
												'Sign In',
												style: TextStyle(
													fontSize: 18,
												),
											),
										),
										Padding(
											padding: EdgeInsets.all(12.0),
											child: Text(
												'Sign Up',
												style: TextStyle(
													fontSize: 18,
												),
											),
										),
									]
								),
								Expanded(
									child: TabBarView(
										controller: tabController,
										children: [
											BlocProvider<SignInBloc>(
												create: (context) => SignInBloc(
													userRepository: context.read<AuthenticationBloc>().userRepository
												),
												child: const SignInPage(),
											),
											BlocProvider<SignUpBloc>(
												create: (context) => SignUpBloc(
													userRepository: context.read<AuthenticationBloc>().userRepository
												),
												child: const SignUpPage(),
											),
										]
									),
								)
							],
						),
					),
				),
			),
		);
  }
}