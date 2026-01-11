import 'package:flutter/material.dart';
import 'onbord_page.dart';
class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  void initState(){
    super.initState();
    const duration=Duration(seconds: 3);
    Future.delayed(duration,(){
      Navigator.pushReplacement(
        context, 
      MaterialPageRoute(builder: (context)=>OnbordPage())
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF63BCE5), 
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center ,
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Spacer(),
             Image.asset(
              'assets/images/logo.png', 
              width: 200,
              height: 200,
              color: Colors.white,
            ),

            const SizedBox(height: 20),
            Spacer(),
            const Text(
              'Travenor',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // Bottom padding space
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
