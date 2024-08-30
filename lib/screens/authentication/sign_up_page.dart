import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barber_shop/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:barber_shop/components/strings.dart';
import 'package:barber_shop/components/textfield.dart';
import 'package:user_repository/user_repository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;
  IconData iconPassword = Icons.visibility_off;
  final nameController = TextEditingController();
  bool signUpRequired = false;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool containsLength = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if(state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if(state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if( state is SignUpFailure) {
          return;
        }
      },
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  validator: (val) {
                    if(val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if(!emailRexExp.hasMatch(val)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  }
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.lock),
                  onChanged: (val) {
                    if (val!.contains(RegExp(r'[A-Z]'))) {
                      setState(() {
                        containsUpperCase = true;
                      });                      
                    } else {
                      setState(() {
                        containsUpperCase = false;
                      });
                    }
                    if (val.contains(RegExp(r'[a-z]'))) {
                      setState(() {
                        containsLowerCase = true;
                      });
                    } else {
                      setState(() {
                        containsLowerCase = false;
                      });
                    }
                    if (val.contains(RegExp(r'[0-9]'))) {
                      setState(() {
                        containsNumber = true;
                      });
                    } else {
                      setState(() {
                        containsNumber = false;
                      });
                    }
                    if (val.contains(specialCharRexExp)) {
                      setState(() {
                        containsSpecialChar = true;
                      });
                    } else {
                      setState(() {
                        containsSpecialChar = false;
                      });
                    }
                    if (val.length >= 8) {
                      setState(() {
                        containsLength = true;
                      });
                    } else {
                      setState(() {
                        containsLength = false;
                      });
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                        if (obscurePassword) {
                          iconPassword = Icons.visibility_off;
                        } else {
                          iconPassword = Icons.visibility;
                        }
                      });
                    },
                    icon: Icon(iconPassword),
                  ),
                  validator: (val) {
                    if(val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if(!passwordRexExp.hasMatch(val)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  }
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("⚈  1 letra maiúscula",
													style: TextStyle(
														color: containsUpperCase
															? Colors.green
															: Theme.of(context).colorScheme.onSurface
													),
												),
												Text(
													"⚈  1 letra minúscula",
													style: TextStyle(
														color: containsLowerCase
															? Colors.green
															: Theme.of(context).colorScheme.onSurface
													),
												),
												Text(
													"⚈  1 número",
													style: TextStyle(
														color: containsNumber
															? Colors.green
															: Theme.of(context).colorScheme.onSurface)
                          ),
                      ],
                  ), 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⚈  1 caractere especial",
													style: TextStyle(
														color: containsSpecialChar
															? Colors.green
															: Theme.of(context).colorScheme.onSurface
													),
												),
												Text(
													"⚈  Mínimo de 8 caracteres",
													style: TextStyle(
														color: containsLength
															? Colors.green
															: Theme.of(context).colorScheme.onSurface 
                            ),
                          ),
                      ],
                  ),
                ], 
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: MyTextField(
                  controller: nameController, 
                  hintText: 'Nome', 
                  obscureText: false, 
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.person),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Por favor, preencha esse campo';
                    } else if (val.length > 30) {
                      return 'Nome muito grande';
                    }
                    return null;
                  }
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              !signUpRequired
                ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child:  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        MyUser myUser = MyUser.empty;
                        myUser = myUser.copyWith(
                          email: emailController.text,
                          name: nameController.text,
                        );
                        setState(() {
                          context.read<SignUpBloc>().add(
                            SignUpRequired(
                              myUser,
                              passwordController.text
                            )
                          );
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)
                      )
                    ),
                    child: const Padding(
                      padding:EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text
                      ('Criar conta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  ),
                )
                :const CircularProgressIndicator()
            ],
          )
        )
      )
    );
  }
}