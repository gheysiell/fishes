import 'package:fishes/features/fishes/data/datasources/remote/fishes_datasource_remote_http.dart';
import 'package:fishes/features/fishes/data/repositories/fishes_repository_impl.dart';
import 'package:fishes/features/fishes/domain/usecases/fishes_usecase.dart';
import 'package:fishes/features/fishes/presentation/viewmodels/fishes_viewmodel.dart';
import 'package:fishes/features/fishes_details/presentation/viewmodels/fishes_details_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  Provider(
    create: (context) => FishesDataSourceRemoteHttpImpl(),
  ),
  Provider(
    create: (context) => FishesRepositoryImpl(
      fishesDataSourceRemoteHttp: context.read<FishesDataSourceRemoteHttpImpl>(),
    ),
  ),
  Provider(
    create: (context) => FishesUseCase(
      fishesRepository: context.read<FishesRepositoryImpl>(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => FishesDetailsViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => FishesViewModel(
      fishesUseCase: context.read<FishesUseCase>(),
    ),
  ),
];
