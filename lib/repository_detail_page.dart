import "package:flutter/material.dart";

class RepositoryDetailPage extends StatelessWidget {
  const RepositoryDetailPage({
    required this.name,
    required this.description,
    required this.avatarUrl,
    required this.language,
    required this.stars,
    required this.watchers,
    required this.forks,
    required this.issues,
    super.key,
  });

  final String name;
  final String description;
  final String avatarUrl;
  final String language;
  final int stars;
  final int watchers;
  final int forks;
  final int issues;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        "Repository Detail Page",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,  // 戻るボタンの色を白に設定
      ),
      backgroundColor: Colors.black,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(avatarUrl),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text("Language: $language"),
          Text("Description: $description"),
          Text("Stars: $stars"),
          Text("Watchers: $watchers"),
          Text("Forks: $forks"),
          Text("Open Issues: $issues"),
        ],
      ),
    ),
  );
}

