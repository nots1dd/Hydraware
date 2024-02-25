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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            spawnMaxRadius: 30,
            spawnMinSpeed: 10.00,
            particleCount: 50,
            spawnMaxSpeed: 50,
            minOpacity: 0.01,
            spawnOpacity: 0.05,
            baseColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        vsync: this,
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Text('Welcome to Hydraware Search Forum!',
                    style: TextStyle(
                        color: Colors.blue[850],
                        fontSize: 14,
                        fontFamily: 'Cera Pro',
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                const Text(
                  'Rules: TBD',
                  style: TextStyle(
                      fontFamily: 'Cera Pro',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w200),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    child: const Text(
                      'To Search Forum',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Cera Pro',
                          decoration: TextDecoration.underline),
                    )),
                const SizedBox(height: 370),
                const ToggleButton(dir: '/chat', icon: Icons.chat_bubble)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
