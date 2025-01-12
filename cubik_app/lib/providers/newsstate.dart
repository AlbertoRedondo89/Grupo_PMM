import 'package:equatable/equatable.dart';
import 'package:cubik_app/models/article.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> articles;

  const NewsLoaded(this.articles);

  @override
  List<Object?> get props => [articles];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object?> get props => [message];
}

class NewsStateWithSelected extends NewsState {
  final List<Article> articles;
  final List<Article> selectedArticles;

  const NewsStateWithSelected(this.articles, this.selectedArticles);

  @override
  List<Object?> get props => [articles, selectedArticles];
}