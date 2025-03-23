import 'package:flutter/material.dart';

import '../../../../config/themes/app_color.dart';
import '../../../../core/utiles/app_size.dart';

class NoPermission extends StatelessWidget {
  const NoPermission({super.key, required this.onPressed});
  final  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.pinkColor,
      appBar: AppBar(
        title: Text("Scanner"),
        backgroundColor: AppColor.pinkColor,
        foregroundColor: AppColor.whiteColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              child: Card(
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      verticalSpace(context, 0.016),
                      Text("Camera Permission Is Required"),
                      verticalSpace(context, 0.016),
                      ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.pinkColor,
                          foregroundColor: AppColor.whiteColor,
                        ),
                        child: Text("Grant Permission"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
