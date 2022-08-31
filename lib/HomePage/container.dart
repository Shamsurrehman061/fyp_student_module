import 'package:flutter/material.dart';

class BoxContainer extends StatelessWidget {
  const BoxContainer({Key? key, required this.pic, required this.text, required this.onPress}) : super(key: key);

  final String pic;
  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context){
    return  GestureDetector(
      onTap: onPress,
      child: Container(
        height: 150.0,
        width: 300.0,
        decoration: BoxDecoration(
          color: Colors.blue[400],
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        child:Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(pic),
                ),
              ),
            ),

             Text(text, style:const TextStyle(fontSize: 22,color: Colors.white, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }

}
