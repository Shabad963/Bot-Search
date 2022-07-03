import 'dart:async';

import 'package:bot_search/core/constants.dart';
import 'package:bot_search/domain/api_services.dart';
import 'package:bot_search/model/user_model.dart';
import 'package:bot_search/views/widgets/bottom_nav.dart';
import 'package:bot_search/views/widgets/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<User> users = [];
  String query = '';
  Timer? debouncer;

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
    final users = await UsersApi.getUsers(query);

    setState(() => this.users = users);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Search',
                style: TextStyle(fontSize: 35),
              ),
              const SizedBox(
                height: 20,
              ),
              buildSearch(),
              const SizedBox(
                height: 22,
              ),
              const Text(
                'ALL RESULTS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: users.isEmpty
                    ? const Center(
                        child: Text('Search not found'),
                      )
                    : GridView.count(
                        childAspectRatio: 1 / 1.3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        crossAxisCount: 2,
                        children: List.generate(
                            users.length,
                            (index) => BotAvatar(
                                  text: "${users[index].name}",
                                  image:
                                      'https://robohash.org/${users[index].name}',
                                )),
                      ),
              ),
            ],
          ),
        )),
        bottomNavigationBar: const BottomNavigationWidget());
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        onChanged: searchName,
      );

  Future searchName(String query) async => debounce(() async {
        final users = await UsersApi.getUsers(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.users = users;
        });
      });
}

class BotAvatar extends StatelessWidget {
  final String text;
  final String image;
  const BotAvatar({Key? key, required this.text, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kblackColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 160,
                  color: const Color.fromARGB(255, 82, 159, 222),
                ),
                Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 160,
                ),
              ],
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
