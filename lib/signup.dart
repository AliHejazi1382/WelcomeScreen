import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:welcome_repair/constant.dart';
import 'package:welcome_repair/signin.dart';
import 'package:welcome_repair/widget.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final List<GlobalKey<FormState>> _formKey =
      List.generate(5, (index) => GlobalKey());
  late List<String> inputs;
  List<bool> bools = List.generate(5, (index) => false);

  late List<FocusNode> focusNode;
  final buttonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    inputs = List.generate(5, (index) => '');
    focusNode = List.generate(5, (index) => FocusNode());
    for (var i = 0; i < 5; i++) {
      focusNode[i].addListener(() {
        if (!focusNode[i].hasFocus && inputs[i].isNotEmpty) {
          bools[i] = !bools[i];
          var d = _formKey[i].currentState!.validate();
          if (d) {
            bools[i] = false;
          }

        }
      });
    }
  }

  @override
  void dispose() {
    focusNode.forEach((element) { element.dispose();});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Scrollbar(
              child: SafeArea(
                child: Stack(
                  children: [
                    CustomScrollView(
                       physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                          children: [
                            Expanded(
                              flex: 1,
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
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0, left: 17.0, bottom: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'SIGN UP',
                                          style: Theme.of(context).textTheme.displaySmall,
                                        ),
                                      ),
                                      Form(
                                        key: _formKey[0],
                                        child: CustomTextField(
                                          maxLength: 10,
                                          autovalidateMode: bools[0] ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                          focusNode: focusNode[0],
                                          textDirection: TextDirection.rtl,
                                          onChanged: (input) {
                                            if (input.isEmpty) {
                                              bools[0] = false;
                                              _formKey[0].currentState!.reset();
                                            }
                                            setState(() {
                                              inputs[0] = input;
                                            });
                                          },
                                          isPassword: false,
                                          inputType: TextInputType.name,
                                          icon: Icons.person,
                                          hint: 'First name',
                                          validator: (input) {
                                            List<String> errors = [];
                                            input = (input ?? '').trim();
                                            if (input.isEmpty) {
                                              errors.add('should not be empty');
                                            }
                                            if ((input.length > 10 || input.length < 3)) {
                                              errors.add('The name should contains 3-10 character');
                                            }

                                            if (!RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(input)) {
                                              errors.add('Enter persian character');
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
                                        child: CustomTextField(
                                          maxLength: 10,
                                          autovalidateMode: bools[1] ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                          focusNode: focusNode[1],
                                          textDirection: TextDirection.rtl,
                                          onChanged: (input) {
                                            setState(() {
                                              inputs[1] = input;
                                            });
                                            if (input.isEmpty) {
                                              _formKey[1].currentState!.reset();
                                            }
                                          },
                                          isPassword: false,
                                          inputType: TextInputType.name,
                                          icon: Icons.person,
                                          hint: 'Last name',
                                          validator: (input) {
                                            List<String> errors = [];
                                            input = (input ?? '').trim();
                                            if (input.isEmpty) {
                                              errors.add('should not be empty');
                                            }
                                            if (!RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(input)) {
                                              errors.add('Enter persian character');
                                            }

                                            if ((input.length > 10 || input.length < 5)) {
                                              errors.add('The name should contains 5-10 character');
                                            }
                                            if (input.contains(inputs[0])) {
                                              errors
                                                  .add('The last name should not contains first name');
                                            }
                                            if (errors.isNotEmpty) {
                                              return errors.join(".\n");
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Form(
                                        key: _formKey[2],
                                        child: CustomTextField(
                                          maxLength: 11,
                                          focusNode: focusNode[2],
                                          autovalidateMode: bools[2] ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                          onChanged: (input) {
                                            setState(() {
                                              inputs[2] = input;
                                            });
                                            if (input.isEmpty) {
                                              _formKey[2].currentState!.reset();
                                            }
                                          },
                                          isPassword: false,
                                          inputType: TextInputType.phone,
                                          icon: Icons.phone,
                                          hint: 'Phone',
                                          validator: (input) {
                                            List<String> errors = [];
                                            input = (input ?? '').trim();
                                            if (input.isEmpty) {
                                              errors.add('Should not be empty');
                                            }
                                            if (!RegExp(r'[0][9][0-9]+').hasMatch(input)) {
                                              errors.add(
                                                  'Please enter valid phone number, starts with 09');
                                            }
                                            if (input.length != 11) {
                                              errors.add('Should be 11 character');
                                            }
                                            if (errors.isNotEmpty) {
                                              return errors.join('.\n');
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Form(
                                        key: _formKey[3],
                                        child: CustomTextField(
                                          focusNode: focusNode[3],
                                          autovalidateMode: bools[3] ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                          onChanged: (input) {
                                            setState(() {
                                              inputs[3] = input;
                                            });
                                            if (input.isEmpty) {
                                              _formKey[3].currentState!.reset();
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
                                        key: _formKey[4],
                                        child: CustomTextField(
                                          maxLength: 12,
                                          autovalidateMode: bools[4] ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                          focusNode: focusNode[4],
                                          onChanged: (input) {
                                            if (input.isEmpty) {
                                              _formKey[4].currentState!.reset();
                                            }
                                            setState(() {
                                              inputs[4] = input;
                                            });
                                          },
                                          isPassword: true,
                                          icon: Icons.lock,
                                          hint: 'Password',
                                          validator: (input) {
                                            List<String> errors = [];
                                            input = (input ?? '').trim();
                                            if (input.isEmpty) {
                                              errors.add('should not be empty');
                                            }
                                            if (inputs[3].isNotEmpty && input.contains(inputs[3])) {
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
                                      CustomButton(
                                        buttonKey: buttonKey,
                                          text: 'SIGN UP',
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

                                            await Future.delayed(const Duration(milliseconds: 50));
                                            //add delay between up and down button

                                            GestureBinding.instance.handlePointerEvent(PointerUpEvent(
                                              position: Offset(x, y),
                                            )); //trigger button down

                                            if (_formKey[0].currentState!.validate() &&
                                                _formKey[1].currentState!.validate() &&
                                                _formKey[2].currentState!.validate() &&
                                                _formKey[3].currentState!.validate() &&
                                                _formKey[4].currentState!.validate()) {
                                              if (!context.mounted) return;
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => SigninPage(
                                                          emailSignUp: inputs[3],
                                                          passwordSignUp: inputs[4],
                                                        )),
                                                (route) => false,
                                              );
                                            }
                                          })
                                    ],
                                  ),
                                ),
                              ),

          ],
        ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            );
  }
}
