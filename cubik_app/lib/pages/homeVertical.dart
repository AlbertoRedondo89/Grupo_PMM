import 'package:cubik_app/providers/newscubit.dart';
import 'package:cubik_app/providers/newsstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cubik_app/widgets/news_List.dart';

class HomeVertical extends StatelessWidget {
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
              return Row(
                children: [
                  // Lista de noticias originales
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: NewsList(
                        news: state.articles,
                        onAdd: (article) =>
                            context.read<NewsCubit>().addToSelected(article),
                      ),
                    ),
                  ),
                  const VerticalDivider(), // Separador entre las listas
                  // Lista de noticias seleccionadas
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: state.selectedArticles.isNotEmpty
                          ? NewsList(news: state.selectedArticles)
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
