import 'package:flutter/material.dart';

class OnbordPage extends StatefulWidget {
  const OnbordPage({super.key});

  @override
  State<OnbordPage> createState() => _OnbordPageState();
}

class _OnbordPageState extends State<OnbordPage> {
  final PageController _controller=PageController();
  int currentPage=0;

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index){
          setState(() {
            currentPage=index;
          });
        },

        children: [
          buildPage(
            image: 'assets/images/onboard1.png',
            title: 'Life is short and the world is ',
            highlight: 'wide',
            description:
                'At Friends tours and travel, we customize reliable and trutworthy educational tours to destinations all over the world.',
            buttonText: 'Get Started',
          ),
          buildPage(
            image: 'assets/images/onboard2.png',
            title: 'It’s a big world out there go ',
            highlight: 'explore',
            description:
                'To get the best of your adventure you just need to leave and go where you like. we are waiting for you.',
            buttonText: 'Next',
          ),
          buildPage(
            image: 'assets/images/onboard3.png',
            title: 'People don’t take trips, trips take ',
            highlight: 'people',
            description:
                'To get the best of your adventure you just need to leave and go where you like. we are waiting for you.',
            buttonText: 'Next',
          ),
        ],
      ),
    );

  }

Widget buildPage({    
    required String image,
    required String title,
    required String highlight,
    required String description,
    required String buttonText,
}){
  return Stack(

    
    children: [
     
      Column(
       
       children: [ Image.asset(image),
        SizedBox(height: 20,),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            ),
            children: [
              TextSpan(text: title),
              TextSpan(text: highlight,style: TextStyle(color: Colors.orange))
            ]
          ),
          
        ),
        
        SizedBox(height: 40,),
  
    Text(
        description,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Color.fromARGB(255, 9, 7, 7)),
      ),
  
    SizedBox(height: 20,),
  
      Row(
        mainAxisAlignment:MainAxisAlignment.center,
        children: List.generate(3, (index)=>Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: currentPage==index?26:10,
            height: 6,
            decoration: BoxDecoration(
                   color: currentPage == index
                  ? Colors.blue
                  : Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)
            ),
        )
        )
      ),

    Spacer(flex: 2,),

      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF63BCE5),
          minimumSize: Size(MediaQuery.of(context).size.width-20, 60)
        ),
        onPressed: () {
          if(currentPage<2){
            _controller.nextPage(
              duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
          }
          else{
            
          }
        },
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),
        ),
      ),
      Spacer(flex: 2,)
    ]
    ),
     Positioned(
      top: 40,
      right: 20,
      child: Text(
        'Skip',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      ),
    ],
  );
}

}