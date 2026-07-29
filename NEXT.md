# Why this course says `programming_language: Plain text`

It is an Ada course. The declaration is a workaround for a closed door upstream, and this file
exists so nobody "fixes" it back and wonders why the course stops loading.

## The wall

`edu-format`'s `com.jetbrains.edu.learning.courseFormat.Language` holds

```
private static final Map<String, String> languages
```

built once in `<clinit>` with **sixteen** hardcoded entries: Python, C/C++, Go, Java, Kotlin, Scala,
JavaScript, Rust, PHP, Shell Script, SQL, C#, unity, Plain text, FakeGradleBasedLanguage.
`CourseBuilder.build()` looks the course's `programming_language` up in it and throws
`Unsupported language 'Ada'` on a miss.

There is no extension point for that map and no setter. The `Educational.configurator` extension
point — which the Ada plugin does implement, correctly — is consulted only *after* a `Course` object
exists. So **the configurator API is open and the course format is closed**: a language JetBrains
has not hardcoded cannot be a course language, however good its plugin support.

That is almost certainly why no third-party JetBrains Academy language support appears to exist
anywhere.

## The workaround

```yaml
programming_language: Plain text   # in the map, so the course loads
environment: Ada                   # what the Ada plugin's configurator matches on
```

`EduConfiguratorManager.findExtension` matches on language **and** courseType **and** environment,
so the Ada plugin registers as `language="TEXT" environment="Ada"` and claims only courses that ask
for Ada — never an ordinary plain-text course. JetBrains' own `PlainTextConfigurator` sits on the
same slot but is gated to internal builds, so there is no live conflict; the environment guard is
about being well-behaved rather than about avoiding one.

What is lost is cosmetic: listings say "Plain text". Editing, highlighting, navigation, building and
testing all key off file extension and are unaffected.

*Create Course Archive* works under the workaround, which was worth confirming rather than assuming,
given that the format rejects unknown languages when writing as well as when reading. The archive's
`course.json` carries `programming_language_id: TEXT` beside `environment: Ada`, so the guard
survives packaging and a distributed archive resolves the Ada configurator exactly as the source
directory does.

## If you are debugging a course that will not load

**Open the offending YAML in the IDE and read the yellow banner.** JetBrains Academy catches every
deserialisation exception, routes it to a message bus, and returns null — nothing reaches
`idea.log`, so a broken course looks like silence. The message is right there in the editor, and
also in `YamlLoadingErrorManager.getInstance(project).getLoadingErrorForFile(file)`.

This one said `Unsupported language 'Ada'` the whole time.

## Reverting, when Ada lands upstream

The change is one entry in `Language.kt` — `"Ada" to "Ada"`. Worth reporting to
`JetBrains/educational-plugin`, with three points:

- an Ada `EduConfigurator` exists and works, and this course demonstrates it end to end;
- the map is the only obstacle, and it has no extension point;
- `ProgrammingLanguageConverter` fails symmetrically on *save*, so a third-party language cannot
  round-trip through the format at all.

When it lands: `programming_language: Ada`, drop `environment`, and change the plugin's configurator
back to `language="Ada"`.
