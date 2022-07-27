import 'package:flutter/material.dart';


class AuthBackground extends StatelessWidget{

  final Widget child;

  const AuthBackground({super.key, required this.child});
  

 @override 
 Widget build(BuildContext context){
    return Container(
      //color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
            _PurpleBox(),
            HeaderIcon(),
            this.child,
        ],
      ),

    );
 }
}

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
      child: Icon(Icons.person_pin, color: Colors.white, size: 75,),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  const _PurpleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _buildBoxDecoration(),
      child: Stack(
        children: [

          Positioned(child: _Buble(), top: 90, left: 30),
          Positioned(child: _Buble(), top: -40, left: 60),
          Positioned(child: _Buble(), top: 120, left: 10)
           
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    gradient: LinearGradient(colors: [
      Color.fromRGBO(63, 63, 156, 1),
      Color.fromRGBO(90, 70, 178, 1)
    ])

  );


}

class _Buble extends StatelessWidget {
  const _Buble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05)

      ),
    );
  }
}