import '../../../utils/exports.dart';
import '../cubit/files_cubit.dart';
import '../repo/files_repository_impl.dart';
import 'widget/file_list_item.dart';

@RoutePage()
class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilesCubit>(
      create: (_) => FilesCubit(
        filesRepository: FilesRepositoryImpl(),
      ),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: MainConfig.appColors.backgroundWhiteColor,
            body: Column(
              children: <Widget>[
                const HomeAppbar(
                  isShadowDisplay: true,
                  title: 'Files',
                ),
                Expanded(
                  child: BlocBuilder<FilesCubit, FilesState>(
                    builder: (BuildContext context, FilesState state) {
                      if (state.status == BaseStateStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state.files.isEmpty) {
                        return Center(
                          child: CustomNoDataWidget(
                            message: 'No files found',
                            description: 'Pick a file to get started',
                            buttonText: 'Pick File',
                            onButtonPressed: () {
                              unawaited(
                                context.read<FilesCubit>().pickFile(),
                              );
                            },
                          ),
                        );
                      }
                      return CustomListView(
                        isPadding: true,
                        itemCount: state.files.length,
                        itemBuilder: (BuildContext context, int index) {
                          final FileModel file = state.files[index];
                          return FileListItem(
                            file: file,
                            onTap: () {
                              unawaited(
                                context.read<FilesCubit>().openFile(file),
                              );
                            },
                            onDelete: () {
                              unawaited(
                                context.read<FilesCubit>().deleteFile(file),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                DebugLog.instance.e("Floating Action Button pressed");
                await context.read<FilesCubit>().pickFile(); // Works now!
              },
              backgroundColor: MainConfig.appColors.mainColor,
              tooltip: 'Pick File',
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
