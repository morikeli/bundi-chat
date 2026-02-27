import 'package:flutter/material.dart';

class FindFriendsScreen extends StatelessWidget {
  const FindFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/imgs/dps/1.jpg'),
                radius: 20.0,
              ),
              title: Text('Test User'),
              subtitle: Text(
                '@testuser',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing: SizedBox(
                height: 28.0,
                child: ElevatedButton(onPressed: () {}, child: Text('Follow')),
              ),
            );
          },
        ),
      ),
    );
  }
}
