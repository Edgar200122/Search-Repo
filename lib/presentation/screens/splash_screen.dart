import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_repositories/core/app_colors.dart';
import 'package:search_repositories/presentation/components/app_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushNamed("repostory_search_screen");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.textFieldColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTexts(
                title: "Search App", fontSize: 16, fontWeight: FontWeight.w600,color: AppColors.containerBackgroundColor,),
            SizedBox(
              height: 20,
            ),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
