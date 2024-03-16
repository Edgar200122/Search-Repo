import 'package:flutter/material.dart';
import 'package:search_repositories/core/app_colors.dart';
import 'package:search_repositories/core/app_images.dart';
import 'package:search_repositories/presentation/components/app_text.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.repoName,
    required this.onTap,
    required this.isSaved,
  }) : super(key: key);

  final String repoName;
  final VoidCallback onTap;
  final bool isSaved;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.containerBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTexts(
            title: repoName,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.appBarTextColor,
          ),
          GestureDetector(
            onTap: onTap,
            child: Image.asset(
              isSaved ? favoriteDeactiv : favoriteActive,
              width: 24,
            ),
          )
        ],
      ),
    );
  }
}
