import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubik_app/models/newsresponse.dart';
import 'package:cubik_app/models/article.dart';
import 'package:http/http.dart' as http;

import 'newsstate.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  List<Article> _articles = []; // Lista de noticias cargadas
  List<Article> _selectedArticles = []; // Lista de noticias seleccionadas

  final String _apiKey = '74b85f61f06b449f8f37474e45c74902';
  final String _baseUrl = 'https://newsapi.org/v2/everything';

  void fetchNews() async {
    try {
      emit(NewsLoading());
      final response = await http.get(
        Uri.parse('$_baseUrl?q=animal&language=es&apiKey=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final newsResponse = NewsResponse.fromJson(response.body);
        _articles = newsResponse.articles; // Guardamos las noticias cargadas
        emit(NewsStateWithSelected(_articles, _selectedArticles));
      } else {
        emit(NewsError('Error al cargar las noticias: ${response.statusCode}'));
      }
    } catch (e) {
      emit(NewsError('Error de conexión: $e'));
    }
  }

  void addToSelected(Article article) {
    if (!_selectedArticles.any((a) => a.title == article.title)) {
      _selectedArticles = List<Article>.from(_selectedArticles)..add(article);
      emit(NewsStateWithSelected(List<Article>.from(_articles), _selectedArticles));
    }
  }

  void removeFromSelected(Article article) {
  if (state is NewsStateWithSelected) {
    final currentState = state as NewsStateWithSelected;

    // Actualizamos la lista de seleccionados eliminando el artículo
    _selectedArticles = List<Article>.from(currentState.selectedArticles)
      ..removeWhere((a) => a.title == article.title);

    // Emitimos el nuevo estado con las listas actualizadas
    emit(NewsStateWithSelected(
      List<Article>.from(currentState.articles),
      _selectedArticles
    ));
  }
}

}
