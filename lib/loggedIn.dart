import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoggedInScreen extends StatelessWidget {
  const LoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light
      ),
      child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/background.jpg'),
                                  fit: BoxFit.cover
                              ),
                            ),
                          )
                      ),
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'LOGGED IN\n',
                                            style: Theme.of(context).textTheme.displaySmall
                                        )
                                      ]
                                  )
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
