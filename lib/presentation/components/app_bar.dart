import 'package:flutter/material.dart';
import 'package:search_repositories/core/app_colors.dart';
import 'package:search_repositories/presentation/components/app_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.widgetOne,
    this.widgetTwo,
    this.ontap,
  }) : super(key: key);
  final String title;
  final Widget? widgetOne;
  final Widget? widgetTwo;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: widgetOne ?? const SizedBox(),
          ),
          AppTexts(
            title: title,
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: AppColors.appBarTextColor,
          ),
          GestureDetector(
            onTap: ontap,
            child: widgetTwo ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
