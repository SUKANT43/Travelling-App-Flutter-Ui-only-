import 'package:flutter/material.dart';

class TopPanelComponent extends StatelessWidget {

  const TopPanelComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final isMobile=size.width<900;

    return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bubble_chart,color: Colors.blue,),
                      const SizedBox(width: 8,),
                        Text(
                        "Sync Up",
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Lucid Imaging",
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              );
  }
}