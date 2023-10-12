import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:welcome_repair/constant.dart';
import 'package:welcome_repair/signin.dart';
import 'package:welcome_repair/widget.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor.withOpacity(0.4)),
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: const TextTheme(
          displaySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(color: Colors.white)
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Colors.white,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          )
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final buttonKey = GlobalKey();

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
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'BAKING LESSONS\n',
                                          style: Theme.of(context).textTheme.displaySmall
                                      ),
                                      TextSpan(
                                          text: 'MASTER THE ART OF BAKING',
                                          style: Theme.of(context).textTheme.headlineSmall
                                      )
                                    ]
                                )
                            ),
                            CustomButton(
                              buttonKey: buttonKey,
                              text: 'START LEARNING',
                              onTap: ()async {
                                RenderBox renderbox = buttonKey.currentContext!.findRenderObject() as RenderBox;
                                Offset position = renderbox.localToGlobal(Offset.zero);
                                double x = position.dx;
                                double y = position.dy;

                                print(x);
                                print(y);


                                GestureBinding.instance.handlePointerEvent(PointerDownEvent(
                                  position: Offset(x, y),
                                )); //trigger button up,

                                await Future.delayed(const Duration(milliseconds: 170));
                                //add delay between up and down button

                                GestureBinding.instance.handlePointerEvent(PointerUpEvent(
                                  position: Offset(x, y),
                                )); //trigger button down
                                if (!context.mounted) return;
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => SigninPage())
                                );
                              }
                            )
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
