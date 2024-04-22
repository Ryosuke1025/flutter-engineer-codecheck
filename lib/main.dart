import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) =>
    MaterialApp(
      title: "GitHub Search",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const GitHubSearchPage(),
    );
}

class GitHubSearchPage extends StatefulWidget {
  const GitHubSearchPage({super.key});

  @override
  State<GitHubSearchPage> createState() => _GitHubSearchPageState();
}

class _GitHubSearchPageState extends State<GitHubSearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _results = [];
  bool _isLoading = false;

  void _search() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse("https://api.github.com/search/repositories?q=${_controller.text}"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _results = data["items"];
        _isLoading = false;
      });
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text("Failed to fetch data: ${response.statusCode}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text(
            "GitHub Repository Search",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search GitHub Repositories",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
              onSubmitted: (String value) {
                _search();
              },
            ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              _results[index]["owner"]["avatar_url"],),
                        ),
                        title: Text(_results[index]["name"]),
                        subtitle: Text(
                            _results[index]["description"] ?? "",),
                      ),
                    ),
            ),
          ],
        ),
      );
}
