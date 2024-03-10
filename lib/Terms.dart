// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Color(0xFFF7F2EF),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        automaticallyImplyLeading: true,
        leadingWidth: 30,
        title: Text(
          "Terms and Condictions",
          style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFFF7F2EF),
      ),
      backgroundColor: Color(0xFFF7F2EF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "1. Agreement:",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                'By downloading or using "A Love Note From Universe," you agree to these Terms and Conditions. If you do not agree with these terms, please refrain from using the application. ',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "2. Services Provided:",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "The application delivers daily motivational quotes to users. Premium features are available through subscription.",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "3. Subscription:",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "Subscribers will be billed as per the selected subscription plan. All payments are final and non-refundable, except as required by law. And all the subscription are auto-renewable after complete the subscription time.",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "4. User Responsibilities:",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "Users must not use the app for illegal or unauthorized purposes. Users agree not to breach any laws in their jurisdiction. Users agree to provide accurate information during registration.",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "5. Intellectual Property:",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                'All content in "A Love Note From Universe" belongs to us or our licensors and is protected by copyright, trademark, and other intellectual property rights.',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "6. Termination:",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "We reserve the right to terminate or suspend your access to our app without prior notice, for conduct that we believe violates these Terms and Conditions or is harmful to other users of the application, us, or third parties, or for any other reason.",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "7. Changes to Terms:",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "We may periodically update these Terms and Conditions. We will notify you of any significant changes.",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "8. Disclaimer:",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                'The app is provided "as is" without any warranties. We do not guarantee that the app will always be available or free from malfunctions or errors.',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "9. Limitation of Liability:",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                'To the maximum extent permitted by applicable law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues.',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                "10. Governing Law:",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              Text(
                'These Terms and Conditions and your use of the app are governed by the laws of the jurisdiction where our company is established.',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black87),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
