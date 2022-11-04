import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/sheared/cubit/cubit.dart';
import 'package:shop_app/sheared/cubit/states.dart';

import '../sheared/componant/text_form_field.dart';

class SettingsScreen extends StatelessWidget {
  @override
  var formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, States>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).GetUserData;
        name.text = model!.data!.name!;
        email.text = model.data!.email!;
        phone.text = model.data!.phone!;
        return Scaffold(
          body: ConditionalBuilder(
            condition: AppCubit.get(context).GetUserData != null,
            builder: (context)=>Container(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    if (state is UpdateUserDataLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 15,
                    ),
                    FormText(
                      context,
                      hintText: 'Name',
                      prefix: Icons.person_outline,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "name can't be not empty";
                        }
                        return null;
                      },
                      control: name,
                      type: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    FormText(
                      context,
                      hintText: "Email",
                      prefix: Icons.email_outlined,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "email can't be not empty";
                        }
                        return null;
                      },
                      control: email,
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    FormText(
                      context,
                      hintText: "Phone",
                      prefix: Icons.phone_android_outlined,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "phone can't be not empty";
                        }
                        return null;
                      },
                      control: phone,
                      type: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              AppCubit.get(context).updateUserDataModel(
                                name: name.text,
                                email: email.text,
                                phone: phone.text,
                              );
                            }
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: Colors.teal)))),
                          child: const Text('  Update  '),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Dark Mode',
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                            onPressed: () {
                              AppCubit.get(context).ChangeMode();
                            },
                            color: Colors.teal,
                            icon: Icon(
                              AppCubit.get(context).DarkLightMode,
                              //color: Colors.white,
                              size: 33,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context)=>const Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }
}
