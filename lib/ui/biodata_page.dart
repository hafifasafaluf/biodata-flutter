import 'package:flutter/material.dart';
import 'package:biodata/bloc/logout_bloc.dart';
import 'package:biodata/bloc/biodata_bloc.dart';
import 'package:biodata/model/biodata.dart';
import 'package:biodata/ui/login_page.dart';
import 'package:biodata/ui/biodata_detail.dart';
import 'package:biodata/ui/biodata_form.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage({Key? key}) : super(key: key);

  @override
  _BiodataPageState createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Biodata'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BiodataForm()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then(
                  (value) => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: BiodataBloc.getBiodataList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListBiodata(list: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListBiodata extends StatelessWidget {
  final List? list;

  const ListBiodata({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemBiodata(biodata: list![i]);
      },
    );
  }
}

class ItemBiodata extends StatelessWidget {
  final Biodata biodata;

  const ItemBiodata({Key? key, required this.biodata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BiodataDetail(biodata: biodata),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(biodata.nama ?? ""),
          subtitle: Text(biodata.alamat ?? ""),
        ),
      ),
    );
  }
}
