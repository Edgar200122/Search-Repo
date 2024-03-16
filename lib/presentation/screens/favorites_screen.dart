import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_repositories/core/app_colors.dart';
import 'package:search_repositories/core/app_images.dart';
import 'package:search_repositories/presentation/components/app_bar.dart';
import 'package:search_repositories/presentation/components/app_text.dart';
import 'package:search_repositories/presentation/components/custom_container.dart';
import 'package:search_repositories/presentation/provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repositoryProvider = context.watch<RepositoryProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 3,
        automaticallyImplyLeading: false,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: CustomAppBar(
          title: 'Favorite repos list',
          widgetOne: Image.asset(
            arrowBackIcon,
            width: 44,
          ),
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: repositoryProvider.getSavedRepositories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: CupertinoActivityIndicator(),
              ),
            );
          } else {
            final savedRepositories = snapshot.data ?? [];
            if (savedRepositories.isEmpty) {
              return const Center(
                child: AppTexts(
                  title:
                      'You have no favorites.\nClick on star while searching to add first favorite',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              );
            } else {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                itemCount: savedRepositories.length,
                itemBuilder: (context, index) {
                  final fullName = savedRepositories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: CustomContainer(
                      isSaved: false,
                      repoName: fullName,
                      onTap: () {
                        repositoryProvider.removeSavedRepository(fullName);
                      },
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
