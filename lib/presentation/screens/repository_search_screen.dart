import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_repositories/core/app_colors.dart';
import 'package:search_repositories/core/app_images.dart';
import 'package:search_repositories/presentation/components/app_bar.dart';
import 'package:search_repositories/presentation/components/app_text.dart';
import 'package:search_repositories/presentation/components/custom_container.dart';
import 'package:search_repositories/presentation/components/search_history.dart';
import 'package:search_repositories/presentation/components/text_field.dart';
import 'package:search_repositories/presentation/provider/provider.dart';

class RepositorySearchScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  RepositorySearchScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 3,
        automaticallyImplyLeading: false,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: CustomAppBar(
          title: 'Github repos list',
          widgetTwo: Image.asset(
            favoriteIcon,
            width: 44,
          ),
          ontap: () {
            Navigator.of(context).pushNamed("favorite_screen");
          },
        ),
      ),
      body: Column(
        children: [
          CustomTextField(
            controller: _textEditingController,
          ),
          Expanded(
            child: _buildRepositoriesList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildRepositoriesList(BuildContext context) {
    final repositoryProvider = context.watch<RepositoryProvider>();
    final searchText = _textEditingController.text.trim();

    if (searchText.isEmpty) {
      return const SearchHistoryWidget();
    } else {
      if (repositoryProvider.isLoading) {
        return const Align(
          alignment: Alignment.topCenter,
          child: CupertinoActivityIndicator(),
        );
      } else if (repositoryProvider.repositories.isEmpty) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppTexts(
                  title: 'What we found',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textFieldColor,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/2.5 ,),
            const AppTexts(
              title:
                  'Nothing was found for your search.\nPlease check the spelling',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ],
        );
      } else {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          itemCount: repositoryProvider.repositories.length,
          itemBuilder: (context, index) {
            final repository = repositoryProvider.repositories[index];
            return FutureBuilder(
              future: repositoryProvider.savedOrNot(repository.fullName),
              builder: ((context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: CustomContainer(
                    repoName: repository.fullName,
                    onTap: () {
                      repositoryProvider
                          .saveSelectedRepository(repository.fullName);
                    },
                    isSaved: snapshot.data ?? false,
                  ),
                );
              }),
            );
          },
        );
      }
    }
  }
}
