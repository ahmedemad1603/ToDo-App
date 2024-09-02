import 'package:flutter/material.dart';

class ToDoWidget extends StatelessWidget
{
  const ToDoWidget({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 27,
        horizontal: 17
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            const SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Play football", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time),
                    const SizedBox(width: 2),
                    Text("${DateTime.now().hour}:${DateTime.now().minute}")
                  ],
                )
              ],
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: (){

                },
                child: const Icon(Icons.check)
            )
          ],
        ),
      ),

    );
  }
}
