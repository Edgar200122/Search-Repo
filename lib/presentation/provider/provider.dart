import 'package:flutter/material.dart';
import 'package:search_repositories/data/repository.dart';
import 'package:search_repositories/domain/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepositoryProvider extends ChangeNotifier {
  final RepositoryData _repositoryData = RepositoryData();
  bool _isLoading = false;
  List<Repository> _repositories = [];
  String _searchQuery = '';
  bool _hasSearched = false;
  bool _isSaved = false;

  bool get isLoading => _isLoading;
  List<Repository> get repositories => _repositories;
  String get searchQuery => _searchQuery;
  bool get hasSearched => _hasSearched;
  bool get isSaved => _isSaved;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void searchRepositories(String text) async {
    try {
      _setLoading(true);
      final repositories =
          await _repositoryData.searchRepositories(_searchQuery);
      _repositories = repositories;
      _hasSearched = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      _setLoading(false);
    }
  }


  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<List<String>> getSavedRepositories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? savedRepoList = prefs.getStringList('savedRepositories');

    return savedRepoList ?? [];
  }

  Future<void> saveSelectedRepository(String fullName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedRepoList =
        prefs.getStringList('savedRepositories') ?? [];

    if (!savedRepoList.contains(fullName)) {
      savedRepoList.add(fullName);
      await prefs.setStringList('savedRepositories', savedRepoList);
      _isSaved = true;
    } else {
      savedRepoList.remove(fullName);
      await prefs.setStringList('savedRepositories', savedRepoList);
      _isSaved = false;
    }
    notifyListeners();
  }

  Future<bool> savedOrNot(String textForSearch) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedRepoList =
        prefs.getStringList('savedRepositories') ?? [];
    return !savedRepoList.contains(textForSearch);
  }

  void removeSavedRepository(String fullName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedRepoList =
        prefs.getStringList('savedRepositories') ?? [];
    if (savedRepoList.contains(fullName)) {
      savedRepoList.remove(fullName);
      await prefs.setStringList('savedRepositories', savedRepoList);
      notifyListeners();
    }
  }

  Future<void> saveSearchQuery(String query) async {
  if (query.trim().isNotEmpty) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searchQueries = prefs.getStringList('searchQueries') ?? [];
    searchQueries.add(query);
    await prefs.setStringList('searchQueries', searchQueries);
  }
}
  Future<List<String>> getSavedSearchQueries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? searchQueries = prefs.getStringList('searchQueries');
    return searchQueries ?? [];
  }
}
