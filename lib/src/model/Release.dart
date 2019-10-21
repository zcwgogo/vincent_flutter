class Release {
  int id;
  String name;
  String body;
  String version;

  DateTime createdAt;
  DateTime publishedAt;

  Release.create(this.id, this.name, this.body,this.version, this.createdAt, this.publishedAt);
}

class Version {
  int version;

  Version.parse(String version) {
    String target=version.replaceAll(".", "");
    this.version = int.parse(target);
  }

  compareTo(Version target){
    return this.version.compareTo(target.version);
  }
}
