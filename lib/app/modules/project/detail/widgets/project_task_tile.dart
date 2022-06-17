import 'package:flutter/material.dart';

class ProjectTaskTile extends StatelessWidget {
  const ProjectTaskTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Nome da task'),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                    text: 'Duração:', style: TextStyle(color: Colors.grey)),
                TextSpan(text: '   '),
                TextSpan(
                    text: '4h',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
