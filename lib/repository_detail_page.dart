import "package:flutter/material.dart";

class RepositoryDetailPage extends StatelessWidget {

  const RepositoryDetailPage({
    required this.name, required this.description, required this.avatarUrl, super.key,
  });
  final String name;
  final String description;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(name),
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
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
}
