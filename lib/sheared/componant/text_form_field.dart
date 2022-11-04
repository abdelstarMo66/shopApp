import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubit/cubit.dart';

Widget FormFields({
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  Widget? icon,
  InputBorder? borderShape = InputBorder.none,
  bool showpassword = false,
  TextEditingController? control,
  FormFieldValidator<String>? validator,
  TextInputType? type,
  ValueChanged<String>? submitted,
}) =>
    TextFormField(
      obscureText: showpassword,
      keyboardType: type,
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 20),
        border: borderShape,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        icon: icon,
        hintText: hintText,
      ),
      controller: control,
      validator: validator,
      onFieldSubmitted: submitted,
    );

Widget FormText(
  context, {
  @required String? hintText,
  IconData? prefix,
  @required FormFieldValidator<String>? validate,
  @required TextEditingController? control,
  @required TextInputType? type,
  bool obscure = false,
  ValueChanged<String>? change,
  ValueChanged<String>? submit,
}) =>
    TextFormField(
      obscureText: obscure,
      style: TextStyle(
          color:
              AppCubit.get(context).DarkMade ? Colors.grey : Color(0xFF292A2F)),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: AppCubit.get(context).DarkMade
                ? Colors.white70
                : Color(0xFF292A2F),
            width: 2.0,
          ),
        ),
        hintText: hintText,
        prefixIcon: Icon(
          color:
              AppCubit.get(context).DarkMade ? Colors.grey : Color(0xFF292A2F),
          prefix,
          size: 28,
        ),
        hintStyle: TextStyle(
          fontSize: 18,
          color:
              AppCubit.get(context).DarkMade ? Colors.grey : Color(0xFF292A2F),
        ),
      ),
      validator: validate,
      controller: control,
      keyboardType: type,
      onChanged: change,
      onFieldSubmitted: submit,
    );
