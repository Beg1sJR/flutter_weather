import 'package:app/features/weather/presentation/pages/search_page.dart';
import 'package:app/features/weather/presentation/widgets/weather_search/search_button.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  void _openSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchPage(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      floating: true,
      snap: true,
      pinned: true,
      expandedHeight: 110.0,

      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_rounded)),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.only(top: 50, left: 16),
          decoration: BoxDecoration(color: Colors.black),
          child: Text(
            'Погода',
            style: theme.textTheme.headlineLarge!.copyWith(
              color: theme.cardColor,
              fontWeight: FontWeight.w700,
              fontSize: 35,
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SearchButton(onTap: () => _openSearch(context)),
        ),
      ),
    );
  }
}
