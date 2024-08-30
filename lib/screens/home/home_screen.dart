import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barber_shop/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
        IconButton(
          onPressed: () {
            context.read<SignInBloc>().add(const SignOutRequired());
          },
          icon: const Icon(Icons.logout),
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ],
        title: Row(
          children: [
            Container(
              width: 50, 
              height: 50, 
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue
              ),
            ),
            const SizedBox(width: 15),
            const Text(
              'Welcome, User',
              style: TextStyle(
                color: Colors.white
              ), 
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ranking Container
                    SizedBox(
                          height: 150,
                          width: 300,
                          child:
                            FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Theme.of(context).colorScheme.onTertiary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),                      
                              child: Image.network('https://firebasestorage.googleapis.com/v0/b/testing-ozt.appspot.com/o/Pins%2Froyal-black.png?alt=media&token=a657d77a-35a7-4959-b424-3ca43568d70d', height: 70, width: 70),
                            ),
                        ),
                    const SizedBox(height: 100),
                    // First 3 icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child:
                            FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: const CircleBorder(),                      
                              child: const Icon(Icons.wallet, color: Colors.white),
                            ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child:
                            FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: const CircleBorder(),                      
                              child: const Icon(Icons.people, color: Colors.white),
                            ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child:
                            FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: const CircleBorder(),                      
                              child: const Icon(Icons.scale, color: Colors.white),
                            ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    // Second 3 icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child:
                            FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: const CircleBorder(),                      
                              child: const Icon(Icons.shopping_bag, color: Colors.white),
                            ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child:
                            FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: const CircleBorder(),                      
                              child: const Icon(Icons.link, color: Colors.white),
                            ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child:
                            FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: const CircleBorder(),
                              child: const Icon(Icons.location_city_rounded, color: Colors.white),
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
  