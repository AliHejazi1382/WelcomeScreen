import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:welcome_repair/constant.dart';
import 'package:welcome_repair/textformfield.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.icon,
    required this.hint,
    this.validator,
    this.inputType,
    required this.isPassword,
    this.onChanged,
    this.focusNode, this.textDirection, this.autovalidateMode, this.maxLength, this.controller
  });
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onChanged;
  final TextInputType? inputType;
  final bool isPassword;
  final IconData icon;
  final int? maxLength;
  final String hint;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextDirection? textDirection;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child:  Row(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 16.0),
          //   child: Align(
          //     alignment: Alignment.topCenter,
          //     child: Icon(
          //       icon,
          //       color: kPrimaryColor,
          //     ),
          //   ),
          // ),
          Expanded(
              child: TextFormField2(
                controller: controller,
                maxLength: maxLength,
                autovalidateMode: autovalidateMode,
                textDirection: textDirection,
                focusNode: focusNode,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(
                      RegExp(r'\s')),
                ],
                onChanged: onChanged,
                obscureText: isPassword,
                keyboardType: inputType,
                style: const TextStyle(color: Colors.white),
                validator: validator,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  isDense: false,
                  counterText: '',
                 // contentPadding: const EdgeInsets.only(bottom: 12.0),
                  hintStyle: const TextStyle(color: Colors.white60),
                  hintText: hint,
                  alignLabelWithHint: true,
                  prefixIcon: Icon(icon, color: kPrimaryColor,)
                ),
              )
          )
        ],
      ),
    );
  }
}
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap
  });
  final String text;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: Container(
          margin: const EdgeInsets.only(bottom: 25.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              onPressed: onTap,
              style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor
              ),
              icon:  const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child:  Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              label: Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 18.0, right: 8.0),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.black
                  ),
                ),
              )
            ),
          )
        ),
    );
  }
}