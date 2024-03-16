import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_repositories/core/app_colors.dart';
import 'package:search_repositories/presentation/components/app_text.dart';
import 'package:search_repositories/presentation/provider/provider.dart';
import 'package:search_repositories/presentation/components/custom_container.dart';

class SearchHistoryWidget extends StatelessWidget {
  const SearchHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSearchHistory(context);
  }

  Widget buildSearchHistory(BuildContext context) {
    final repositoryProvider = context.watch<RepositoryProvider>();

    return FutureBuilder<List<String>>(
      future: repositoryProvider.getSavedSearchQueries(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final searchQueries = snapshot.data ?? [];
          if (searchQueries.isEmpty) {
            return const Center(
              child: AppTexts(
                title:
                    'You have empty history.\nClick on search to start journey!',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            );
          }

          final last15SearchQueries = searchQueries.length > 15
              ? searchQueries.sublist(searchQueries.length - 15)
              : searchQueries;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: AppTexts(
                    title: 'Search History',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textFieldColor,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: last15SearchQueries.length,
                    itemBuilder: (context, index) {
                      final searchQuery = last15SearchQueries[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: CustomContainer(
                          repoName: searchQuery,
                          onTap: () {
                            repositoryProvider.setSearchQuery(searchQuery);
                            repositoryProvider.searchRepositories(searchQuery);
                          },
                          isSaved: true,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
