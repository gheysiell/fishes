import 'package:fishes/core/models/title_and_info.dart';
import 'package:fishes/features/fishes/domain/entities/fishes_entity.dart';
import 'package:fishes/features/fishes_details/presentation/viewmodels/fishes_details_viewmodel.dart';
import 'package:fishes/shared/palette.dart';
import 'package:fishes/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FishesDetailsView extends StatefulWidget {
  final Fish fish;
  const FishesDetailsView({
    super.key,
    required this.fish,
  });

  @override
  State<FishesDetailsView> createState() {
    return FishesDetailsViewState();
  }
}

class FishesDetailsViewState extends State<FishesDetailsView> {
  late FishesDetailsViewModel fishesDetailsViewModel;
  List<TitleAndInfo> titlesAndInfos = [];
  bool initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      fishesDetailsViewModel = context.watch<FishesDetailsViewModel>();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        fishesDetailsViewModel.setFish(widget.fish);

        titlesAndInfos = [
          TitleAndInfo(
            title: 'ID',
            info: fishesDetailsViewModel.fish!.id.toString(),
          ),
          TitleAndInfo(
            title: 'Nome',
            info: fishesDetailsViewModel.fish!.name,
          ),
          TitleAndInfo(
            title: 'Nome científico',
            info: fishesDetailsViewModel.fish!.binomialName,
          ),
          TitleAndInfo(
            title: 'Estado de conservação',
            info: fishesDetailsViewModel.fish!.conservationStatus,
          ),
        ];
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fish',
          style: TextStyle(
            fontSize: 22,
            color: Palette.gray,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Palette.gray,
          ),
          tooltip: 'Voltar',
        ),
        backgroundColor: Palette.white,
        surfaceTintColor: Palette.white,
      ),
      backgroundColor: Palette.white,
      body: ListView.builder(
        itemCount: titlesAndInfos.length + 1,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          int indexAfterImage = index - 1;

          return index == 0
              ? Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 200,
                  child: TextButton(
                    onPressed: () {
                      Functions.showNetworkImageFullScreen(context, fishesDetailsViewModel.fish!.imageUrl);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: fishesDetailsViewModel.fish!.imageUrl,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image(
                          image: imageProvider,
                        ),
                      ),
                      errorWidget: (context, url, error) => const SizedBox(
                        child: FaIcon(
                          FontAwesomeIcons.fish,
                          size: 150,
                          color: Palette.grayLight,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 8,
                  ),
                  color: Functions.isPair(indexAfterImage) ? Palette.creamy : Palette.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width * 0.3),
                        alignment: Alignment.topLeft,
                        child: Text(
                          titlesAndInfos[indexAfterImage].title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Palette.gray,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            titlesAndInfos[indexAfterImage].info,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Palette.gray,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
