import 'package:flutter/material.dart';
import 'package:flutter_project/features/search/screens/search_page.dart';

class CustomSearchText extends StatefulWidget {
  const CustomSearchText({super.key});

  @override
  State<CustomSearchText> createState() => _CustomSearchTextState();
}

class _CustomSearchTextState extends State<CustomSearchText> {
  final focusNode = FocusNode();
  bool isTextFieldFocused = false;
  late TextEditingController _searchController;
  OverlayEntry? entry;
  String? kotaPost;

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    entry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        top: offset.dy + size.height + 8,
        child: buildOverlay(),
      ),
    );

    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  final List<String> _listKota = [
    'Jakarta',
    'Bali',
    'Surabaya',
    'Bandung',
    'Medan',
    'Makassar',
    'Palembang',
    'Bekasi',
    'Surakarta',
    'Manado',
    'Mataram',
    'Pontianak',
    'Kuoang',
    'Banjarmasin'
  ];

  List _foundKota = [];
  @override
  initState() {
    super.initState();
    _searchController = TextEditingController();
    _foundKota = _listKota;
    WidgetsBinding.instance.addPostFrameCallback((_) => hideOverlay());

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showOverlay();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _filterKota(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results = _listKota;
    } else {
      results = _listKota
          .where((kota) => kota.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundKota = results;
      print('ini found kota $_foundKota');
      hideOverlay();
      showOverlay();
    });
  }

  Widget buildOverlay() => Material(
        elevation: 8,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 500,
              width: double.infinity,
              child: ListView.builder(
                itemCount: _foundKota.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  final kota = _foundKota[index];
                  return ListTile(
                    title: Text(kota),
                    onTap: () {
                      // Aksi yang akan dijalankan ketika item dipilih
                      print('Anda memilih kota: $kota');
                      kotaPost = kota;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchPage(namaKota: kota)));
                      hideOverlay();
                      focusNode.unfocus();
                      // Contoh lain: Navigasi ke halaman detail kota
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CityDetail(city)));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.top,
      controller: _searchController,
      decoration: InputDecoration(
        prefixIcon: isTextFieldFocused || _searchController.text.isNotEmpty
            ? null
            : const Icon(
                Icons.search,
                color: Colors.grey,
              ),
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.all(4.0),
        hintText: 'Search..',
        border: InputBorder.none,
        alignLabelWithHint: true,
        hintMaxLines: 1,
      ),
      onChanged: (value) => _filterKota(value),
    );
  }
}
