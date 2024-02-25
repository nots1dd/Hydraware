import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hydraware/components/chat_textfield.dart';
import 'package:hydraware/components/threedots.dart';
import 'package:profanity_filter/profanity_filter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String?> messages = [];
  final filter = ProfanityFilter();
  bool _istyping = false;
  final ScrollController _scrollController = ScrollController();
  void invalidAuth(String message) {
    showDialog(
      context: context,
      barrierColor: Theme.of(context).colorScheme.onBackground.withAlpha(80),
      builder: (context) {
        return Dialog(
          elevation: 1.0,
          child: Container(
            width: 30,
            height: 40,
            decoration: BoxDecoration(
              // color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 16,
                        fontFamily: 'Cera Pro')),
              ),
            ),
          ),
        );
      },
    );
  }

  final List<String?> messages = [];
  final filter = ProfanityFilter();
  bool _istyping = false;
  final ScrollController _scrollController = ScrollController();

  final msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double containerWidth = screenSize.width * 0.1;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          automaticallyImplyLeading: false,
          title: const Text("Hydraware Support",
              style: TextStyle(fontFamily: 'Cera Pro')),
          leading: KeyboardDismissOnTap(
            dismissOnCapturedTaps: true,
            child: IconButton(
              onPressed: () async {
                Future.delayed(const Duration(milliseconds: 200), () {
                  Navigator.pop(context);
                });
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: double.infinity),
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.surface,
              child: Text(
                "You are currently talking to a chatbot",
                style: TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: index % 2 == 0
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                child: Align(
                                  alignment: index % 2 == 0
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: index % 2 == 0
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .background,
                                      borderRadius: BorderRadius.circular(9),
                                      border: Border.all(
                                        width: 1.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: index % 2 == 0
                                            ? CrossAxisAlignment.start
                                            : CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            index % 2 == 0
                                                ? "You"
                                                : "Hydraware Support",
                                            style: TextStyle(
                                                fontFamily: 'Cera Pro',
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: index % 2 == 0
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .background
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                            textAlign: TextAlign.justify,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${messages[index]}",
                                            style: TextStyle(
                                                fontFamily: 'Cera Pro',
                                                color: index % 2 == 0
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .background
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onBackground),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                          ],
                        ));
                  }),
            ),
            if (_istyping == true) const ThreeDots(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChatTextField(
                msgController: msgController,
                submit: () {
                  if (filter.hasProfanity(msgController.text)) {
                    invalidAuth("Please do not use profanity");
                    return;
                  } else if (msgController.text.isEmpty) {
                    prompt('Empty message, try again!');
                  } else {
                    submit();
                  }
                },
              ),
            ),
          ],
        ));
  }

  void submit() {
    setState(() {
      _istyping = true;
      messages.add(msgController.text);
      final gemini = Gemini.instance;
      gemini
          .chat([
            Content(parts: [
              Parts(
                  text:
                      'You are an chat supporting assistant for the application Hydraware. If any queries or issues regarding the application were to be asked, you are to answer it respectfully and in detail. If you are unable to answer the query, you are to transfer the chat to a higher authority. You are not to use any profanity or inappropriate language. You are to be respectful and professional at all times. You are to be available at all times. You are to be polite and helpful at all times. You are to be patient and understanding at all times. You are to be knowledgeable about the application at all times. You are to be able to answer any query regarding the application at all times. You are to be able to solve any issue regarding the application at all times. You are to be able to transfer the chat to a higher authority at all times. You are to be able to provide a detailed and respectful answer to any query regarding the application at all times. You are to be able to provide a detailed and respectful answer to any query regarding the application at all times. You are to be able to provide a detailed and respectful answer to any query regarding the application at all times. You are to be able to provide a detailed and respectful answer to any query regarding the application at all times. You are to be able to provide a detailed and respectful answer to any query regarding the application at all times. You are to be able to provide a detailed and respectful answer to any query regarding the application at all times. You are to be able to provide a detailed and respectful answer to any query regarding the application at all times. You are to be able to provide a detailed and respectful answer to any query regarding the application at all times.'),
            ], role: 'user'),
            Content(parts: [
              Parts(
                  text:
                      'I am Hydraware chat support assistant. I am here to help you with any queries or issues regarding the application. How may I help you today?')
            ], role: 'model'),
            Content(parts: [
              Parts(
                  text:
                      'Hydraware is a cross-platform application dedicated to providing a platform for an easier way to view one\'s local hydrological and fresh water situation, and provides the means of communicating with other users and local water authorities, and gives a forum to avail fresh water supply contacts. It also aims at pushing announcements regarding the water analysis of a particular area with the help of Machine Learning.')
            ], role: 'user'),
            Content(parts: [
              Parts(
                  text:
                      'I am Hydraware chat support assistant. I am here to help you with any queries or issues regarding the application. I do not have the answer to your query. Make sure that your queries are related to Hydraware. If I am unable to answer your valid query then I will transfer the chat to a higher authority. Please wait for a moment.')
            ], role: 'model'),
            Content(parts: [
              Parts(
                  text:
                      'You are Hydraware chat support assistant. Any queries or issues not pertaining to the application are to be responded by \'I am sorry, I am unable to answer your query. I will transfer the chat to a higher authority. Please wait for a moment.\'')
            ], role: 'user'),
            Content(parts: [
              Parts(
                  text:
                      'I am Hydraware chat support assistant. I am here to help you with any queries or issues regarding the application. How may I help you today?')
            ], role: 'model'),
            Content(parts: [
              Parts(
                  text:
                      'In case of any irrelevant queries, make sure to notify the user that you are only there to help with queries and issues regarding Hydraware. If the user persists, transfer the chat to a higher authority.')
            ], role: 'user'),
            Content(parts: [
              Parts(
                  text:
                      'I am Hydraware chat support assistant. I will make sure to notify the user that I am only there to help with queries and issues regarding Hydraware. If the user persists, I will transfer the chat to a higher authority.')
            ], role: 'model'),
            Content(parts: [Parts(text: msgController.text)], role: 'user'),
          ])
          .then((value) => setState(() => {
                if (value != null)
                  {messages.add(value.output)}
                else
                  {
                    messages.add(
                        'Error: Kindly ask relevant queries to the chat bot as it is designed to only assist with Hydraware related issues only!.')
                  }
              }))
          .catchError((e) => setState(() => messages.add('Error: $e')));
      msgController.clear();
      _istyping = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
}
