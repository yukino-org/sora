import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import '../modules/anime/gogoanime_pe/test.dart' as gogoanime_pe;
import '../modules/anime/hanime_tv/test.dart' as hanime_tv;
import '../modules/anime/tenshi_moe/test.dart' as tenshi_moe;
import '../modules/anime/zoro_to/test.dart' as zoro_to;
import '../modules/manga/fanfox_net/test.dart' as fanfox_net;
import '../modules/manga/mangadex_org/test.dart' as mangadex_org;
import '../modules/manga/readm_org/test.dart' as readm_org;

abstract class TestFiles {
  static final Map<TenkaLocalFileDS, MockedAnimeExtractor> anime =
      <TenkaLocalFileDS, MockedAnimeExtractor>{
    gogoanime_pe.source: gogoanime_pe.mocked,
    hanime_tv.source: hanime_tv.mocked,
    tenshi_moe.source: tenshi_moe.mocked,
    zoro_to.source: zoro_to.mocked,
  };

  static final Map<TenkaLocalFileDS, MockedMangaExtractor> manga =
      <TenkaLocalFileDS, MockedMangaExtractor>{
    fanfox_net.source: fanfox_net.mocked,
    mangadex_org.source: mangadex_org.mocked,
    readm_org.source: readm_org.mocked,
  };
}
