import 'package:flutter/material.dart';

class dadosWidget extends StatelessWidget {
  final String title;
  final String content;

  const dadosWidget({required this.title, required this.content});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              Row(
                // COMEÇO DA TERCEIRA LINHA DE DADOS
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$title:",
                          style: TextStyle(fontSize: 15, color: Colors.black45),
                        ),
                        Text(
                          "$content",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Divider(
            color: Colors.black12, //color of divider
            height: 5, //height spacing of divider
            thickness: 1, //thickness of divier line
            indent: 5, //spacing at the start of divider
            endIndent: 5, //spacing at the end of divider
          ),
        ),
      ],
    );
  }
}
