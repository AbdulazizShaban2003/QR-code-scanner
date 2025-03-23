import 'package:flutter/cupertino.dart';


double responsiveHeight(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * height;
  }
  double responsiveWidth(BuildContext context, double width) {
    return MediaQuery.of(context).size.width * width;
  }
  
SizedBox verticalSpace(BuildContext context, double height) =>
    SizedBox(height: MediaQuery.of(context).size.height * height);

SizedBox horizontalSpace(BuildContext context, double width) =>
    SizedBox(width: MediaQuery.of(context).size.width * width);
