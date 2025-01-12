import 'package:cubik_app/models/article.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;
  final Function(Article)? onAdd;    // Función para añadir noticias
  final Function(Article)? onRemove; // Función para eliminar noticias

  const NewsList({Key? key, required this.news, this.onAdd, this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (news.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: article.urlToImage != null && article.urlToImage!.isNotEmpty
                    ? NetworkImage(article.urlToImage!)
                    : const AssetImage('assets/no-image.jpg') as ImageProvider,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title.isNotEmpty ? article.title : 'Sin título',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    article.description != null && article.description!.isNotEmpty
                        ? article.description!
                        : 'Sin descripción',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  if (onAdd != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => onAdd!(article),
                        child: const Text('Añadir'),
                      ),
                    ),
                  if (onRemove != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => onRemove!(article),
                        child: const Text(
                          'Eliminar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

