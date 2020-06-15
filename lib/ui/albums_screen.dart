import 'package:albums/model/albums.dart';
import 'package:albums/model/result.dart';
import 'package:albums/network/remote_data_source.dart';
import 'package:flutter/material.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumsScreen> {
  String _title;
  RemoteDataSource _apiResponse = RemoteDataSource();

  void initState() {
    super.initState();
  }

  //Method to show progressbar in a dialog
//  showProgressDialog() => showDialog(
//      context: context, builder: (BuildContext context) => ProgressDialog());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Center(
        child: FutureBuilder(
            future: _apiResponse.getAlbums(),
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                Gallery albums = (snapshot.data as SuccessState).value;
                return ListView.builder(
                    itemCount: albums.albumList.length,
                    itemBuilder: (context, index) {
                      return albumListTile(index, albums, context);
                    });
              } else if (snapshot.data is ErrorState) {
                String error = (snapshot.data as ErrorState).msg;
                return Text(error);
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}

ListTile albumListTile(int index, Gallery albumList, BuildContext context) {
  return ListTile(
    leading: Icon(Icons.photo_album),
    title: Text(albumList.albumList[index].title),
    subtitle: Text(
      albumList.albumList[index].title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.caption,
    ),
    isThreeLine: true,
//    trailing: Text(
//      albumList.albums[index].,
//      style: Theme.of(context).textTheme.caption,
//    ),
  );
}
