import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/register/register_cubit/register_cubit.dart';
import 'package:shop_app/modules/register/register_cubit/register_states.dart';

import '../../sheared/componant/navigate.dart';
import '../../sheared/componant/text_form_field.dart';
import '../../sheared/style/background_login_register.dart';
import '../login/login.dart';

class RegisterScreen extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.modelData.status!) {
              Fluttertoast.showToast(
                msg: state.modelData.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            } else {
              Fluttertoast.showToast(
                msg: state.modelData.message.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                fontSize: 16.0,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Container(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Background(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 260),
                            margin: const EdgeInsets.only(bottom: 90),
                            child: Text(
                              "Register",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Container(
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 70,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomRight: Radius.circular(100),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 16, right: 32),
                                        child: FormFields(
                                          hintText: 'name',
                                          icon: Icon(Icons.person_outlined),
                                          type: TextInputType.name,
                                          control: name,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Name can not be Empty';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 16, right: 32),
                                        child: FormFields(
                                          hintText: 'Email',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Email must not be empty';
                                            }
                                            return null;
                                          },
                                          icon: Icon(Icons.email_outlined),
                                          control: email,
                                          type: TextInputType.emailAddress,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 16, right: 32),
                                        child: FormFields(
                                          showpassword: cubit.showPassword,
                                          type: TextInputType.visiblePassword,
                                          hintText: 'Password',
                                          submitted: (value) {
                                            if (formKey.currentState!
                                                .validate()) {
                                              cubit.RegisterUser(
                                                email: email.text,
                                                password: password.text,
                                                name: name.text,
                                                phone: phone.text,
                                              );
                                            }
                                          },
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              cubit.changevisibility();
                                            },
                                            icon: cubit.suffix,
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Password too short';
                                            }
                                            return null;
                                          },
                                          icon: Icon(Icons.lock_open_outlined),
                                          control: password,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 16, right: 32),
                                        child: FormFields(
                                          hintText: 'Phone',
                                          icon: Icon(Icons.phone_outlined),
                                          type: TextInputType.phone,
                                          control: phone,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Phone can not be Empty';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 15, top: 65),
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green[200]!
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      color: Colors.teal,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          RegisterCubit.get(context)
                                              .RegisterUser(
                                                  email: email.text,
                                                  password: password.text,
                                                  name: name.text,
                                                  phone: phone.text);
                                        }
                                      },
                                      icon: ConditionalBuilder(
                                        builder: (context) => Icon(
                                          Icons.arrow_forward_outlined,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                        fallback: (context) =>
                                            CircularProgressIndicator(
                                          color: Colors.black54,
                                        ),
                                        condition:
                                            state is! RegisterLoadingState,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(right: 7, top: 16),
                                child: Text(
                                  "You Have an account?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.grey),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(right: 16, top: 16),
                                child: TextButton(
                                  child: const Text(
                                    "Login Now",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  onPressed: () {
                                    NavigateAndFinish(context, Login_Screen());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
