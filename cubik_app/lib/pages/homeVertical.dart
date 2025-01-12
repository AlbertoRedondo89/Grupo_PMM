import 'package:cubik_app/providers/newscubit.dart';
import 'package:cubik_app/providers/newsstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubik_app/widgets/news_List.dart';

class HomeVertical extends StatefulWidget {
  @override
  _HomeVerticalState createState() => _HomeVerticalState();
}

class _HomeVerticalState extends State<HomeVertical> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Home'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => NewsCubit()..fetchNews(),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsStateWithSelected) {
              return PageView(
                controller: _pageController,
                children: [
                  // Página de todas las noticias
                  Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: NewsList(
                            news: state.articles,
                            onAdd: (article) =>
                                context.read<NewsCubit>().addToSelected(article),
                            scrollController: _scrollController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Página de noticias favoritas
                  Scaffold(
                    appBar: AppBar(
                      title: const Text('Noticias Favoritas'),
                      centerTitle: true,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(10),
                      child: state.selectedArticles.isNotEmpty
                          ? NewsList(
                              news: state.selectedArticles,
                              onRemove: (article) =>
                                  context.read<NewsCubit>().removeFromSelected(article),
                            )
                          : const Center(child: Text('No hay noticias seleccionadas.')),
                    ),
                  ),
                ],
              );
            } else if (state is NewsError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Sin noticias disponibles'));
          },
        ),
      ),
    );
  }
}
