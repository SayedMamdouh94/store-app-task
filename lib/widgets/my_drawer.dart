import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/provider/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Theme Setting",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RadioListTile<bool>(
                    title: Text(
                      'Light Theme',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    value: false,
                    groupValue: themeProvider.isDarkTheme,
                    onChanged: (value) {
                      if (value == false) {
                        themeProvider.toggleTheme();
                      }
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                  RadioListTile<bool>(
                    title: Text(
                      'Dark Theme',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    value: true,
                    groupValue: themeProvider.isDarkTheme,
                    onChanged: (value) {
                      if (value == true) {
                        themeProvider.toggleTheme();
                      }
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
