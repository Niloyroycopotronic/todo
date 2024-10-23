import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Todolist extends StatelessWidget {
  const Todolist({
    super.key,
    required this.taskName,
    required this.tackCompleted,
    required this.onChanged,
    required this.deleteFunction
  });

  final String taskName;
  final bool tackCompleted;
  final Function(bool?)? onChanged;

  final Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 0,
      ),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                  onPressed: deleteFunction,
                  icon: Icons.delete,
                  borderRadius: BorderRadius.circular(15),
              )
            ]
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Checkbox(
                  value: tackCompleted,
                  onChanged: onChanged,
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                side: const BorderSide(color: Colors.white)
              ),
              Text(
                taskName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: tackCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                    decorationColor: Colors.white,
                  decorationThickness: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}