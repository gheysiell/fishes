import 'package:fishes/features/fishes/presentation/viewmodels/fishes_viewmodel.dart';
import 'package:fishes/features/fishes_details/presentation/views/fishes_details_view.dart';
import 'package:fishes/shared/palette.dart';
import 'package:fishes/shared/input_styles.dart';
import 'package:fishes/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FishesView extends StatefulWidget {
  const FishesView({super.key});

  @override
  State<FishesView> createState() {
    return FishesViewState();
  }
}

class FishesViewState extends State<FishesView> {
  late FishesViewModel fishesViewModel;
  final ScrollController scrollController = ScrollController();
  final TextEditingController controllerSearch = TextEditingController();
  final FocusNode focusSearch = FocusNode();
  final double heightAppBar = 130;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      fishesViewModel = context.watch<FishesViewModel>();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await fishesViewModel.getFishes('');
      });

      scrollController.addListener(() {
        if (focusSearch.hasFocus) focusSearch.unfocus();
      });

      initialized = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(heightAppBar),
          child: AppBar(
            leading: Container(
              height: double.infinity,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/icon.png',
                height: double.infinity,
              ),
            ),
            titleSpacing: 0,
            leadingWidth: 70,
            title: const Text(
              'Fishes',
              style: TextStyle(
                fontSize: 22,
                color: Palette.gray,
                fontWeight: FontWeight.w700,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 4,
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  controller: controllerSearch,
                  focusNode: focusSearch,
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    fillColor: Palette.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 30,
                    ),
                    border: InputStyles.borderSide,
                    enabledBorder: InputStyles.borderSide,
                    focusedBorder: InputStyles.borderSide,
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 30,
                      color: Palette.grayMedium,
                    ),
                    suffixIcon: fishesViewModel.searching
                        ? IconButton(
                            onPressed: () {
                              controllerSearch.clear();
                              fishesViewModel.getFishes('');
                            },
                            icon: const Icon(
                              Icons.clear_rounded,
                              size: 30,
                              color: Palette.grayMedium,
                            ),
                            tooltip: 'Limpar pesquisa',
                          )
                        : null,
                    label: fishesViewModel.searching || controllerSearch.text.isNotEmpty || focusSearch.hasFocus
                        ? null
                        : const Text(
                            'Pesquisar',
                            style: TextStyle(
                              fontSize: 17,
                              color: Palette.grayMedium,
                            ),
                          ),
                  ),
                  onFieldSubmitted: (String value) async {
                    focusSearch.unfocus();
                    fishesViewModel.getFishes(controllerSearch.text);
                  },
                ),
              ),
            ),
            backgroundColor: Palette.white,
            surfaceTintColor: Palette.white,
          ),
        ),
        backgroundColor: Palette.white,
        body: SizedBox(
          height: Functions.getHeightBody(context, null),
          width: double.infinity,
          child: fishesViewModel.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await fishesViewModel.getFishes(controllerSearch.text);
                  },
                  child: !fishesViewModel.loading && fishesViewModel.fishes.isEmpty
                      ? SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: Functions.getHeightBody(context, heightAppBar),
                            child: Column(
                              children: [
                                const Spacer(),
                                Container(
                                  height: 180,
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/images/icon.png',
                                  ),
                                ),
                                const Text(
                                  'Peixes não encontrados',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Palette.grayMedium,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: fishesViewModel.fishes.length,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    controller: scrollController,
                                    itemBuilder: (BuildContext context, int index) {
                                      return ListTile(
                                        leading: SizedBox(
                                          width: 90,
                                          height: double.infinity,
                                          child: TextButton(
                                            onPressed: () {
                                              Functions.showNetworkImageFullScreen(
                                                  context, fishesViewModel.fishes[index].imageUrl);
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: fishesViewModel.fishes[index].imageUrl,
                                              placeholder: (context, url) => const Center(
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 3,
                                                ),
                                              ),
                                              imageBuilder: (context, imageProvider) {
                                                return ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Image(
                                                    image: imageProvider,
                                                  ),
                                                );
                                              },
                                              errorWidget: (context, url, error) => const SizedBox(
                                                child: FaIcon(
                                                  FontAwesomeIcons.fish,
                                                  size: 50,
                                                  color: Palette.grayLight,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          fishesViewModel.fishes[index].name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Palette.gray,
                                          ),
                                        ),
                                        subtitle: Text(
                                          fishesViewModel.fishes[index].binomialName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Palette.grayMedium,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FishesDetailsView(
                                                fish: fishesViewModel.fishes[index],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 25,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Palette.white,
                                      Palette.white.withOpacity(0.9),
                                      Palette.white.withOpacity(0.7),
                                      Palette.white.withOpacity(0.2),
                                      Palette.white.withOpacity(0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
        ),
      ),
    );
  }
}
