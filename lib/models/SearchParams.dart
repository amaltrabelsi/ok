class SearchParams {
  final int typeSearch; // 1: OneWay | 2: RoundTrip | 3: Multi
  final String? departVol1;
  final String? destinationVol1;
  final String? departleVol1;
  final String? retourleVol1;
  final int qteADT;
  final int qteCHD;
  final int qteINF;
  final String classe;
  final bool calender;
  final String? refundable;
  final List<String> typGds;

  SearchParams({
    required this.typeSearch,
    this.departVol1,
    this.destinationVol1,
    this.departleVol1,
    this.retourleVol1,
    required this.qteADT,
    this.qteCHD = 0,
    this.qteINF = 0,
    this.classe = "Y",
    this.calender = false,
    this.refundable = "O",
    this.typGds = const ["G", "L"],
  });

  Map<String, dynamic> toJson() {
    return {
      "typeSearch": typeSearch,
      "departVol1": departVol1,
      "destinationVol1": destinationVol1,
      "departleVol1": departleVol1,
      if (retourleVol1 != null) "retourleVol1": retourleVol1,
      "qteADT": qteADT,
      "qteCHD": qteCHD,
      "qteINF": qteINF,
      "classe": classe,
      "refundable": refundable,
      "typGds": typGds,
      "calender": calender,
    };
  }

  factory SearchParams.fromJson(Map<String, dynamic> json) {
    return SearchParams(
      typeSearch: json["typeSearch"],
      departVol1: json["departVol1"],
      destinationVol1: json["destinationVol1"],
      departleVol1: json["departleVol1"],
      retourleVol1: json["retourleVol1"],
      qteADT: json["qteADT"] ?? 1,
      qteCHD: json["qteCHD"] ?? 0,
      qteINF: json["qteINF"] ?? 0,
      classe: json["classe"] ?? "Y",
      calender: json["calender"] ?? false,
      refundable: json["refundable"] ?? "O",
      typGds: List<String>.from(json["typGds"] ?? ["G", "L"]),
    );
  }
}
