import 'package:flutter/material.dart';
import 'package:hydraware/components/toggle_button.dart';
import 'package:hydraware/pages/search_screens/search_btn.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const ToggleButton(
          dir: '/chat',
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: TextField(
                    style: TextStyle(
                        fontFamily: 'Cera Pro',
                        color: Theme.of(context).colorScheme.onSurface),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2.5),
                        ),
                        fillColor: Theme.of(context).colorScheme.background,
                        filled: true,
                        hintText: 'Search',
                        suffixIcon: SearchBtn(
                          controller: controller,
                        ))),
              ),
            ],
          ),
        ));
  }
}
