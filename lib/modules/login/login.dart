import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/models/info_user_model.dart';
import 'package:shop_app/modules/login/login_cubit/login_cubit.dart';
import 'package:shop_app/modules/login/login_cubit/login_states.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/sheared/componant/navigate.dart';
import 'package:shop_app/sheared/componant/text_form_field.dart';
import 'package:shop_app/sheared/constant/constant.dart';
import 'package:shop_app/sheared/cubit/cubit.dart';

import '../../sheared/network/local/cashe_helper.dart';
import '../../sheared/style/background_login_register.dart';

class Login_Screen extends StatelessWidget {
  LoginModel? LoginData;
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: Container(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Background(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 260),
                            margin: const EdgeInsets.only(bottom: 90),
                            child: Text(
                              "Login",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Container(
                            height: 150,
                            child: Stack(
                              children: [
                                Container(
                                  height: 150,
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
                                              cubit.loginUser(
                                                email: email.text,
                                                password: password.text,
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
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 15),
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
                                          LoginCubit.get(context).loginUser(
                                            email: email.text,
                                            password: password.text,
                                          );
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
                                        condition: state is! LoginLoadingState,
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
                                  "don't have an account?",
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
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  onPressed: () {
                                    NavigateAndFinish(
                                        context, RegisterScreen());
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
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.modelData.status!) {
              CacheHelper.saveData(
                key: 'token',
                value: state.modelData.data!.token,
              ).then((value) {
                token = state.modelData.data!.token;
                NavigateAndFinish(context, Shop_layout());
                AppCubit.get(context).homeData();
              });

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
      ),
    );
  }
}
