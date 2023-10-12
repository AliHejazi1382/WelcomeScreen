import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:welcome_repair/constant.dart';
import 'package:welcome_repair/loggedIn.dart';
import 'package:welcome_repair/signup.dart';
import 'package:welcome_repair/widget.dart';

class SigninPage extends StatefulWidget {
  SigninPage({super.key, this.emailSignUp, this.passwordSignUp});
  final String? emailSignUp;
  final String? passwordSignUp;

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  final List<String> inputs = List.generate(5, (index) => '');
  late List<FocusNode> focusNode;
  final List<bool> bools = List.generate(5, (index) => false);
  final List<GlobalKey<FormState>> _formKey = List.generate(5, (index) => GlobalKey());
  final buttonKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    focusNode = List.generate(5, (index) => FocusNode());
    for (int i = 0; i < 5; i++) {
      focusNode[i].addListener(() {
        if (!focusNode[i].hasFocus && inputs[i].isNotEmpty) {
          bools[i] = !bools[i];
          var isValidate = _formKey[i].currentState!.validate();
          if (isValidate) {
            bools[i] = false;
          }
        }
      });
    }
  }

  @override
  void dispose() {
    focusNode.forEach((element) { element.dispose(); });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true,
        child: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                physics: const ClampingScrollPhysics(),
                //shrinkWrap: true,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Stack(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/background.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.centerRight)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0, left: 17.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'SIGN IN',
                                            style: Theme.of(context).textTheme.displaySmall,
                                          ),
                                          TextButton(
                                            key: buttonKey,
                                            onPressed: () async {
                                              RenderBox renderbox = buttonKey.currentContext!.findRenderObject() as RenderBox;
                                              Offset position = renderbox.localToGlobal(Offset.zero);
                                              double x = position.dx;
                                              double y = position.dy;

                                              print(x);
                                              print(y);


                                              GestureBinding.instance.handlePointerEvent(PointerDownEvent(
                                                position: Offset(x, y),
                                              )); //trigger button up,

                                              await Future.delayed(Duration(milliseconds: 250));
                                              //add delay between up and down button

                                              GestureBinding.instance.handlePointerEvent(PointerUpEvent(
                                                position: Offset(x, y),
                                              )); //trigger button down

                                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                            ),
                                            child: Text(
                                              'SIGN UP',
                                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Form(
                                      key: _formKey[0],
                                      autovalidateMode: bools[0] ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                      child: CustomTextField(
                                        focusNode: focusNode[0],
                                        onChanged: (input) {
                                          setState(() {
                                            inputs[0] = input;
                                          });
                                          if (input.isEmpty) {
                                            _formKey[0].currentState!.reset();
                                          }
                                        },
                                        isPassword: false,
                                        inputType: TextInputType.emailAddress,
                                        icon: Icons.alternate_email,
                                        hint: 'Email Address',
                                        validator: (input) {
                                          List<String> errors = [];
                                          input = (input ?? '').trim();
                                          if (input.isEmpty) {
                                            errors.add('should not be empty');
                                          }

                                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                              .hasMatch(input)) {
                                            errors.add('enter valid email address');
                                          }
                                          if (errors.isNotEmpty) {
                                            return errors.join('.\n');
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Form(
                                      key: _formKey[1],
                                      autovalidateMode: bools[1] ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                      child: CustomTextField(
                                        focusNode: focusNode[1],
                                        onChanged: (input) {
                                          setState(() {
                                            inputs[1] = input;
                                          });
                                          if (input.isEmpty) {
                                            _formKey[1].currentState!.reset();
                                          }
                                        },
                                        maxLength: 12,
                                        isPassword: true,
                                        icon: Icons.lock,
                                        hint: 'Password',
                                        validator: (input) {
                                          List<String> errors = [];
                                          input = (input ?? '').trim();
                                          if (input.isEmpty) {
                                            errors.add('should not be empty');
                                          }
                                          if (input.contains(inputs[0])) {
                                            errors.add('password should not contains email');
                                          }

                                          if (input.length > 12 || input.length < 8) {
                                            errors.add('The name should contains 8-12 character');
                                          }

                                          if (!RegExp(r'[a-zA-Z]')
                                              .hasMatch(input)) {
                                            errors.add(
                                                'should contains english letters');
                                          }

                                          if (!RegExp(r'\d').hasMatch(input)) {
                                            errors.add('should contains numbers.');
                                          }

                                          if (errors.isNotEmpty) {
                                            return errors.join('.\n');
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const Spacer(),
                                    CustomButton(
                                      buttonKey: buttonKey,
                                      text: 'SIGN IN',
                                      onTap: () async {
                                        RenderBox renderbox = buttonKey.currentContext!.findRenderObject() as RenderBox;
                                        Offset position = renderbox.localToGlobal(Offset.zero);
                                        double x = position.dx;
                                        double y = position.dy;

                                        print(x);
                                        print(y);


                                        GestureBinding.instance.handlePointerEvent(PointerDownEvent(
                                          position: Offset(x, y),
                                        )); //trigger button up,

                                        await Future.delayed(Duration(milliseconds: 50));
                                        //add delay between up and down button

                                        GestureBinding.instance.handlePointerEvent(PointerUpEvent(
                                          position: Offset(x, y),
                                        )); //trigger button down
                                        if (_formKey[0].currentState!.validate() && _formKey[1].currentState!.validate()) {
                                          if (!context.mounted) return;
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(builder: (context) => const LoggedInScreen()),
                                                  (route) => false
                                          );
                                        }
                                      },
                                    )
                                  ],
                                ),
                              )
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}




