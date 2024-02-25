import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:hydraware/components/toggle_button.dart';

class SearchForumIntroScreen extends StatefulWidget {
  const SearchForumIntroScreen({super.key});

  @override
  State<SearchForumIntroScreen> createState() => _SearchForumIntroScreenState();
}

class _SearchForumIntroScreenState extends State<SearchForumIntroScreen>
    with TickerProviderStateMixin {
  final userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          const ToggleButton(dir: '/chat', icon: Icons.chat_bubble),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            spawnMaxRadius: 30,
            spawnMinSpeed: 10.00,
            particleCount: 60,
            spawnMaxSpeed: 50,
            minOpacity: 0.01,
            spawnOpacity: 0.05,
            baseColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        vsync: this,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Hydraware Forum',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 40,
                                fontFamily: 'Cera Pro',
                                fontWeight: FontWeight.bold))
                      ])),
                      const SizedBox(height: 20),
                      Text(
                        'Rules: TBD',
                        style: TextStyle(
                            fontFamily: 'Cera Pro',
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 20,
                            fontWeight: FontWeight.w200),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/search');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.forum),
                            ),
                            Text('Start talking!',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  fontFamily: 'Cera Pro',
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 370),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
