import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state_management/view_state.dart';
import '../../locator/locator.dart';
import '../../models/album.dart';
import 'home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('home page rebuild');
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => locator()
        ..initPosts()
        ..initAlbums(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'App Bar',
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<HomeViewModel>(
                builder: (context, model, child) {
                  debugPrint('Posts rebuild');
                  switch (model.viewState1) {
                    case ViewState.initial:
                    case ViewState.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ViewState.error:
                      return Center(
                        child: Text(model.errorMsg),
                      );
                    case ViewState.success:
                      final posts = model.posts;
                      return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                posts[index].title,
                              ),
                              subtitle: Text(
                                posts[index].body,
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ),
            Expanded(
              child: Selector<HomeViewModel, Tuple2<ViewState, List<Album>>>(
                selector: (context, model) =>
                    Tuple2(model.viewState2, model.albums),
                builder: (context, model, child) {
                  final model = context.read<HomeViewModel>();
                  debugPrint('albums rebuild');

                  switch (model.viewState2) {
                    case ViewState.initial:

                    case ViewState.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ViewState.error:
                      return Text(model.errorMsg);
                    case ViewState.success:
                      final albums = model.albums;
                      return ListView.builder(
                        itemCount: albums.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(albums[index].title),
                          );
                        },
                      );
                  }
                },
              ),
            ),
            Expanded(
              child: Consumer<HomeViewModel>(
                builder: (context, value, child) => TextButton(
                  child: Text('Delete'),
                  onPressed: () {
                    Provider.of<HomeViewModel>(context, listen: false)
                        .deletePosts();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
