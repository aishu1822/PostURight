import 'package:flutter/material.dart';
TextField loginTextField(String text, bool isPasswordType, TextEditingController controller) {
  return TextField (
                  controller: controller,
                  obscureText: isPasswordType,
                  enableSuggestions: !isPasswordType,
                  autocorrect: !isPasswordType,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  decoration: InputDecoration(
                    // prefixIcon: Icon(),
                    labelText: text,
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.black.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                  keyboardType: isPasswordType ? TextInputType.visiblePassword : TextInputType.emailAddress,
                );                
}