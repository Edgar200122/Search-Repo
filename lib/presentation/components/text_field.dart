import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_repositories/core/app_colors.dart';
import 'package:search_repositories/core/app_images.dart';
import 'package:search_repositories/presentation/provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repositoryProvider = context.watch<RepositoryProvider>();
    final isFocused = repositoryProvider.isLoading;
    final isTextNotEmpty = controller.text.isNotEmpty;
    final fillColor = isFocused
        ? AppColors.containerBackgroundColor
        : AppColors.textFieldbackgroundColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextField(
        cursorColor: AppColors.textFieldColor,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          labelStyle: const TextStyle(color: AppColors.textColor),
          hintText: 'Search',
          hintStyle: const TextStyle(color: AppColors.textColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: AppColors.containerBackgroundColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: AppColors.textFieldColor,
              width: 2,
            ),
          ),
          prefixIcon: GestureDetector(
            onTap: () {
              // repositoryProvider.searchRepositories(controller.text);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                searchIcon,
                width: 24,
              ),
            ),
          ),
          suffixIcon: isTextNotEmpty
              ? GestureDetector(
                  onTap: () {
                    controller.clear();
                    FocusScope.of(context).unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      closeIcon,
                      width: 24,
                    ),
                  ),
                )
              : null,
        ),
        onChanged: (value) {
             repositoryProvider.setSearchQuery(value);
              repositoryProvider.searchRepositories(controller.text);
             repositoryProvider.saveSearchQuery(value);
        },
      ),
    );
  }
}
