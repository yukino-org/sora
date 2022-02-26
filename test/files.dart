import 'package:tenka/tenka.dart';
import 'package:tenka_dev_tools/tenka_dev_tools.dart';
import '../extensions/anime/gogoanime_pe/test.dart' as gogoanime_pe;
import '../extensions/anime/hanime_tv/test.dart' as hanime_tv;
import '../extensions/anime/tenshi_moe/test.dart' as tenshi_moe;
import '../extensions/anime/twist_moe/test.dart' as twist_moe;
import '../extensions/anime/zoro_to/test.dart' as zoro_to;
import '../extensions/manga/fanfox_net/test.dart' as fanfox_net;
import '../extensions/manga/mangadex_org/test.dart' as mangadex_org;
import '../extensions/manga/readm_org/test.dart' as readm_org;

abstract class TestFiles {
  static final Map<TenkaLocalFileDS, MockedAnimeExtractor> anime =
      <TenkaLocalFileDS, MockedAnimeExtractor>{
    gogoanime_pe.source: gogoanime_pe.mocked,
    hanime_tv.source: hanime_tv.mocked,
    tenshi_moe.source: tenshi_moe.mocked,
    twist_moe.source: twist_moe.mocked,
    zoro_to.source: zoro_to.mocked,
  };

  static final Map<TenkaLocalFileDS, MockedMangaExtractor> manga =
      <TenkaLocalFileDS, MockedMangaExtractor>{
    fanfox_net.source: fanfox_net.mocked,
    mangadex_org.source: mangadex_org.mocked,
    readm_org.source: readm_org.mocked,
  };
}
