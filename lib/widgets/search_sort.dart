import 'package:flutter/material.dart';

class SearchAndSort extends StatelessWidget {
  const SearchAndSort({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.secondary,
            ),
            width: 240,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Search',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.sort_outlined,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
