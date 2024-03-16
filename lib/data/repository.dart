import 'package:dio/dio.dart';
import 'package:search_repositories/domain/repository.dart';

class RepositoryData {
  final Dio _dio = Dio();

  Future<List<Repository>> searchRepositories(String query) async {
    try {
      final response = await _dio.get(
        'https://api.github.com/search/repositories?q=$query',
      );

      if (response.statusCode == 200) {
        final List<dynamic> items = response.data['items'];
        return items
            .take(15)
            .map((item) => Repository(
                  fullName: item['full_name'],
                  description: item['description'],
                ))
            .toList();
      } else {
        throw Exception('Failed to load repositories');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load repositories');
    }
  }
  
}
