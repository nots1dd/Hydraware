import 'package:flutter/material.dart';
import 'package:hydraware/components/helpline_tile.dart';

class HelplineScreen extends StatefulWidget {
  const HelplineScreen({super.key});

  @override
  State<HelplineScreen> createState() => _HelplineScreenState();
}

class _HelplineScreenState extends State<HelplineScreen> {
  final TextEditingController searchController = TextEditingController();
  List<int> helplineNumbers = [2345678901, 1234567890]; // Add your helpline numbers here
  List<int> filteredNumbers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Helpline Services',style: TextStyle(fontFamily: 'Cera Pro'),),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15,),
          SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: TextStyle(fontFamily: 'Cera Pro', color: Theme.of(context).colorScheme.tertiary),
                  decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),),
                fillColor: Theme.of(context).colorScheme.secondary,
                filled: true,
                hintText: 'Search',
                prefixIcon: Icon(Icons.search,color: Theme.of(context).colorScheme.tertiary,),
                ),
                
                
                ),),
             ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: helplineNumbers.length,
            itemBuilder: (BuildContext context, int index) {
              final number = helplineNumbers[index];
              final shouldShow = searchController.text.isEmpty || number.toString().contains(searchController.text);
              return shouldShow ? HelpLineTile(phoneNumber: number) : const SizedBox.shrink();
          },
          ),
        ],
      ),
  );
  }
}