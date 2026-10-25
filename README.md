# interval_timer

An interval timer app for iOS, built with Flutter.

## Development

Run these checks before you commit:

```sh
flutter analyze && flutter test
```

### Enable the Git hook

Git does not enable hooks from the repository on clone. Run this command once:

```sh
git config core.hooksPath .githooks
```

After that, the `pre-commit` hook runs the same checks before each commit.
