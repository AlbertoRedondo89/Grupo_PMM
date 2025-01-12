import 'package:cubik_app/models/article.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;
  final Function(Article)? onAdd;    // Función para añadir noticias
  final Function(Article)? onRemove; // Función para eliminar noticias
  final ScrollController? scrollController; // Controlador de desplazamiento opcional

  const NewsList({Key? key, required this.news, this.onAdd, this.onRemove, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (news.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      controller: scrollController,
      itemCount: news.length,
      itemBuilder: (_, int index) => _NewsListItem(
        article: news[index],
        onAdd: onAdd,
        onRemove: onRemove,
      ),
    );
  }
}

class _NewsListItem extends StatelessWidget {
  final Article article;
  final Function(Article)? onAdd;    // Función para añadir noticias
  final Function(Article)? onRemove; // Función para eliminar noticias

  const _NewsListItem({Key? key, required this.article, this.onAdd, this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: article.urlToImage != null && article.urlToImage!.isNotEmpty
                    ? NetworkImage(article.urlToImage!)
                    : const AssetImage('assets/no-image.jpg') as ImageProvider,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              article.description ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onAdd != null)
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => onAdd!(article),
                  ),
                if (onRemove != null)
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => onRemove!(article),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
