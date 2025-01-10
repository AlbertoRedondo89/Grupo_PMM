import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubik_app/models/newsresponse.dart';
import 'package:cubik_app/models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'newsstate.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  final String _apiKey = '74b85f61f06b449f8f37474e45c74902';
  final String _baseUrl = 'https://newsapi.org/v2/everything';

 void fetchNews() async {
    try {
      emit(NewsLoading());
      final response = await http.get(
        Uri.parse('https://newsapi.org/v2/everything?q=animal&language=es&apiKey=74b85f61f06b449f8f37474e45c74902'),
      );

      if (response.statusCode == 200) {
        final newsResponse = NewsResponse.fromJson(response.body);
        print('Noticias cargadas: ${newsResponse.articles.length}');

        emit(NewsLoaded(newsResponse.articles));
      } else {
        print('Error en la respuesta de la API: ${response.statusCode}');
        emit(NewsError('Error al cargar las noticias: ${response.statusCode}'));
      }
    } catch (e, stackTrace) {
      print('Excepción capturada: $e');
      print('StackTrace: $stackTrace');
      emit(NewsError('Error de conexión: $e'));
    }
  }
}
