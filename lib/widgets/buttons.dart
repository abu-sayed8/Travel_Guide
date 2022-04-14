import 'package:flutter/material.dart';

Widget button(BuildContext context, String buttonName) {
  Size size = MediaQuery.of(context).size;
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    child: Container(
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).primaryColor,
      ),
      child: Text(
        buttonName,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: size.width / 20),
      ),
    ),
  );
}
Widget outlineIconButton(BuildContext context, IconData iconData, String buttonName, Color color,void btnMethod) {
  Size size = MediaQuery.of(context).size;
  return InkWell(
    onTap:()=> btnMethod,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: color),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: size.width*.04,
            color: color,
          ),
          SizedBox(width: 5),
          Text(
            buttonName,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.width*.035, color: color),
          )
        ],
      ),
    ),
  );
}