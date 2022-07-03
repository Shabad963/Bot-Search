import 'package:bot_search/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home,
              color: kGreyColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: kGreyColor,
            ),
            onPressed: () {},
          ),
          Container(
            width: 75,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 233, 30, 186),
                  Color.fromARGB(255, 233, 30, 220),
                  Colors.pink,
                  Colors.orange
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.2, 0.8, 1],
              ),
            ),
            child: const Icon(
              Icons.add,
              color: kGreyColor,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.messenger_outline_rounded,
              color: kGreyColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.account_box,
              color: kGreyColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
