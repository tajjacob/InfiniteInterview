import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview_infinite/custom_widgets/search_widget.dart';
import 'package:interview_infinite/models/reqres.dart';
import 'package:interview_infinite/values/strings.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Data> books = [];
  String query = '';
  Timer? debouncer;

  Regres? regres;
  List<Data>? dataList;

  static Future<List<Data>> getBooks(String query) async {
    final url = Uri.parse(Const.contactApiUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List books = json.decode(response.body);

      return books.map((json) => Data.fromJson(json)).where((book) {
        final titleLower = book.firstName.toLowerCase();
        final authorLower = book.lastName.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<Data>?> getUserList() async {
    final response = await http.get(Uri.parse(Const.contactApiUrl));
    if (response.statusCode == 200) {
      regres = Regres.fromJson(jsonDecode(response.body));
      setState(() {
        dataList = regres!.data;
      });
      return dataList;
    } else {
      dataList = null;
    }
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final books = await getBooks(query);

    setState(() => this.books = books);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Search Contact'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];

                  return buildBook(book);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final books = await getBooks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.books = books;
        });
      });

  Widget buildBook(Data data) => ListTile(
        leading: Image.network(
          data.avatar.toString(),
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(data.firstName.toString()),
        subtitle: Text(data.lastName.toString()),
      );
}
