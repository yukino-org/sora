import 'package:sora_builder/sora_builder.dart';

class _Urls extends SoraUrls {
  final String ghUsername = 'yukino-org';
  final String ghReponame = 'sora';
  final String ghMainBranch = 'main';
  final String ghDistBranch = 'dist';

  @override
  String repositoryUrl() =>
      'https://github.com/$ghUsername/$ghReponame/tree/$ghMainBranch';

  @override
  String storeBaseUrl() =>
      'https://raw.githubusercontent.com/$ghUsername/$ghReponame/$ghDistBranch';
}

final _Urls $urls = _Urls();
