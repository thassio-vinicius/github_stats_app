enum ProgrammingLanguage {
  assembly("Assembly"),
  c("C"),
  cpp("C++"),
  csharp("C#"),
  clojure("Clojure"),
  coffeescript("Coffeescript"),
  crystal("Crystal"),
  d("D"),
  dart("Dart"),
  elixir("Elixir"),
  erlang("Erlang"),
  fsharp("F#"),
  go("Go"),
  groovy("Groovy"),
  haskell("Haskell"),
  html("HTML"),
  java("Java"),
  javascript("Javascript"),
  julia("Julia"),
  kotlin("Kotlin"),
  lua("Lua"),
  matlab("MATLAB"),
  objectiveC("Objective-C"),
  ocaml("OCaml"),
  pascal("Pascal"),
  perl("Perl"),
  php("PHP"),
  python("Python"),
  r("R"),
  ruby("Ruby"),
  rust("Rust"),
  scala("Scala"),
  shell("Shell"),
  swift("Swift"),
  typescript("Typescript"),
  visualBasic("Visual Basic"),
  none("none"),
  zig("Zig");

  final String key;
  const ProgrammingLanguage(this.key);
}

class ProgrammingLanguageHelper {
  static const Map<ProgrammingLanguage, String> _languageToExtension = {
    ProgrammingLanguage.assembly: '.asm',
    ProgrammingLanguage.c: '.c',
    ProgrammingLanguage.cpp: '.cpp',
    ProgrammingLanguage.csharp: '.cs',
    ProgrammingLanguage.clojure: '.clj',
    ProgrammingLanguage.coffeescript: '.coffee',
    ProgrammingLanguage.crystal: '.cr',
    ProgrammingLanguage.d: '.d',
    ProgrammingLanguage.dart: '.dart',
    ProgrammingLanguage.elixir: '.ex',
    ProgrammingLanguage.erlang: '.erl',
    ProgrammingLanguage.fsharp: '.fs',
    ProgrammingLanguage.go: '.go',
    ProgrammingLanguage.groovy: '.groovy',
    ProgrammingLanguage.haskell: '.hs',
    ProgrammingLanguage.html: '.html',
    ProgrammingLanguage.java: '.java',
    ProgrammingLanguage.javascript: '.js',
    ProgrammingLanguage.julia: '.jl',
    ProgrammingLanguage.kotlin: '.kt',
    ProgrammingLanguage.lua: '.lua',
    ProgrammingLanguage.matlab: '.m',
    ProgrammingLanguage.objectiveC: '.m',
    ProgrammingLanguage.ocaml: '.ml',
    ProgrammingLanguage.pascal: '.pas',
    ProgrammingLanguage.perl: '.pl',
    ProgrammingLanguage.php: '.php',
    ProgrammingLanguage.python: '.py',
    ProgrammingLanguage.r: '.r',
    ProgrammingLanguage.ruby: '.rb',
    ProgrammingLanguage.rust: '.rs',
    ProgrammingLanguage.scala: '.scala',
    ProgrammingLanguage.shell: '.sh',
    ProgrammingLanguage.swift: '.swift',
    ProgrammingLanguage.typescript: '.ts',
    ProgrammingLanguage.visualBasic: '.vb',
    ProgrammingLanguage.zig: '.zig',
  };

  static String? getExtension(ProgrammingLanguage language) {
    return _languageToExtension[language];
  }

  static ProgrammingLanguage? getProgrammingLanguage(String extension) {
    return _languageToExtension.entries
        .firstWhere((entry) => entry.value == extension,
            orElse: () => const MapEntry(ProgrammingLanguage.none, ''))
        .key;
  }
}
