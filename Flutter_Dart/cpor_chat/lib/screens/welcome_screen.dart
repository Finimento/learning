import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cpor_chat/components/rounded_button.dart';
import 'package:cpor_chat/screens/login_screen.dart';
import 'package:cpor_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {

  static String id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>  with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(duration: Duration(seconds: 3), vsync: this,);
    animation = ColorTween(
      /// andere Tweens sind auch möglich:  [AlignmentGeometryTween, AlignmentTween, BorderRadiusTween, BorderTween, BoxConstraintsTween, ColorTween, ConstantTween, DecorationTween, EdgeInsetsGeometryTween, EdgeInsetsTween, FractionalOffsetTween, IntTween, MaterialPointArcTween, Matrix4Tween, RectTween, RelativeRectTween, ReverseTween, ShapeBorderTween, SizeTween, StepTween, TextStyleTween, ThemeDataTween]
      begin: Colors.blueGrey,
      end: Colors.white,
    ).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    // Animationskurve difinieren
    /*animation = CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate
    );*/


    // Animation dauerhaft forwärts und rückwärts abspielen
    /*animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller.reverse(from: 1);
      }else if (status == AnimationStatus.dismissed){
        controller.forward();
      }
    });*/
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: "logo",
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60,
                    ),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Cpor Chat',
                      cursor: "_",
                      textStyle: TextStyle(
                        fontSize: 38,
                        color: Colors.grey[850]
                      ),
                      speed: const Duration(seconds: 1),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: Colors.lightBlueAccent,
              onPressed: () {Navigator.pushNamed(context, LoginScreen.id);},
            ),
            RoundedButton(
              title: 'Register',
              color: Colors.blueAccent,
              onPressed: () {Navigator.pushNamed(context, RegistrationScreen.id);},
            ),
          ],
        ),
      ),
    );
  }
}
