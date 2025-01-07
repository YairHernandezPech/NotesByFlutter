import 'package:flutter/material.dart';

class BubbleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Burbujas flotantes
        const Positioned(
          left: -200,
          top: 200,
          child: AnimatedBubble(size: 400),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width - 150,
          top: 80,
          child: const AnimatedBubble(size: 350),
        ),
        const Positioned(
          left: 70,
          top: 50,
          child: AnimatedBubble(size: 150),
        ),
        const Positioned(
          left: 200,
          top: 450,
          child: AnimatedBubble(size: 180),
        ),
        const Positioned(
          left: 90,
          top: 600,
          child: AnimatedBubble(size: 80),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width - 50,
          top: 600,
          child: const AnimatedBubble(size: 150),
        ),
        const Positioned(
          left: 250,
          top: 50,
          child: AnimatedBubble(size: 60),
        ),
        const Positioned(
          left: 10,
          top: 50,
          child: AnimatedBubble(size: 40),
        ),
         const Positioned(
          left: 10,
          top: 50,
          child: AnimatedBubble(size: 40),
        ),
        const Positioned(
          left: 10,
          top: 650,
          child: AnimatedBubble(size: 40),
        ),
        const Positioned(
          left: 250,
          top: 680,
          child: AnimatedBubble(size: 20),
        ),

      ],
    );
  }
}




class AnimatedBubble extends StatefulWidget {
  final double size; // Nuevo parámetro para el tamaño

  const AnimatedBubble({Key? key, required this.size}) : super(key: key);

  @override
  _AnimatedBubbleState createState() => _AnimatedBubbleState();
}

class _AnimatedBubbleState extends State<AnimatedBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 0, end: -50).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Container(
            width: widget.size,  // Usa el tamaño pasado como parámetro
            height: widget.size, // Usa el tamaño pasado como parámetro
            decoration: const BoxDecoration(
              color: Color.fromARGB(78, 127, 134, 238), // Color de la burbuja
              shape: BoxShape.circle,
              
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}