import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posturight/registration3.dart';
import 'colors.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Registration3Screen()),
    );
  }

  // Widget _buildFullscreenImage() {
  //   return Image.asset(
  //     'assets/fullscreen.jpg',
  //     fit: BoxFit.cover,
  //     height: double.infinity,
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //   );
  // }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width, height: 330,);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: appBackgroundColor,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      globalHeader: const Align(
        alignment: Alignment.topLeft,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top:0),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Privacy and your PostURight Sensor",
          bodyWidget: RichText(
                        text: const TextSpan(text:"At PostURight, we value your privacy and are committed to protecting your personal information. This privacy disclaimer is designed to inform you of how we collect, use, and store your personal data when you use our wearable posture sensor.\n\n" +
  "Collection of Data: We collect data related to your posture using our wearable posture sensor. This includes data such as your body position, movement, and activity. We may also collect personal information such as your email address and device information.\n\n" +
  "Use of Data: The data we collect is used to improve our products and services, and to provide you with personalized feedback on your posture. We may also use your personal information to communicate with you regarding product updates, offers, and promotions.\n\n" +
"Sharing of Data: We do not sell your personal data to third parties. However, we may share your data with trusted third-party service providers who help us in providing our products and services. We may also share data with law enforcement agencies, regulatory authorities, or legal counsel, if required by law.\n\n" +
"Data Storage: We take all reasonable precautions to safeguard your personal information. We store your data securely in our systems and protect it from unauthorized access, disclosure, alteration, or destruction." +
"Consent: By using our wearable posture sensor, you consent to the collection, use, and storage of your personal data in accordance with this privacy disclaimer.\n\n" +
"Changes to Privacy Disclaimer: We may update this privacy disclaimer from time to time. Any changes will be posted on our website, and we encourage you to review this privacy disclaimer periodically.\n\n" +
"Opt out Policy: " +
"You may opt-out of receiving any, or all, of these communications from Us by following the unsubscribe link or instructions provided in any email We send or by contacting us.\n\n" +
"Contact Us: If you have any questions or concerns regarding our privacy disclaimer or our data handling practices, please contact us at help@posturight.com\n\n" +
"Thank you for choosing PostURight and trusting us with your personal information.", style: TextStyle(color: Colors.black)),
textAlign: TextAlign.left,
                      ),
          decoration: const PageDecoration(bodyAlignment: Alignment.topLeft, ),
        ),
        PageViewModel(
          title: "Make sure the power cable is plugged into your sensor\n",
          bodyWidget: _buildImage('images/plug_in_instructions.png'),
          decoration: const PageDecoration(imageAlignment: Alignment.center, titlePadding: EdgeInsets.only(top: 24)),         

        ),
        PageViewModel(
          title: "Place the sensor on your upper back as shown",
          bodyWidget: _buildImage('images/back_placement.png'),
          decoration: const PageDecoration(imageAlignment: Alignment.topCenter),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      showNextButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Text('Back', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Text('Next', style: TextStyle(fontWeight: FontWeight.w600)),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 20.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Color.fromARGB(255, 9, 57, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}