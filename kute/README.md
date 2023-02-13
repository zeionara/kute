# kute

## Starting server

The server allows to generate unique identifiers for incoming requests with different degrees of uniqueness constraints. To start the server execute the following command:

```sh
swift run kute serve --port 1717
```

or for short just

```sh
swift run kute serve -p 1717
```

Besides port a random `seed` can be provided to guarantee that every time the sequence of generated `word tokens` will be the same:

```sh
swift run kute serve --seed 17
```

or

```sh
swift run kute serve -s 17
```

Also flag `--bare` can be passed to initialize an empty registry instead of registry with content loaded from the `Assets/registry-snapshot.json` file:

```sh
swift run kute serve --bare
```

or

```sh
swift run kute serve -b
```

## Usage

The simplest use case is referring to the root of the server to generate a token:

```sh
curl localhost:1717
```

The response looks like this:

```json
{
    "uuid":"foo-550a3a27-123c-499f-aad1-8091ff41a0ff-bar",
    "date":"foo-13-02-2023@20:46:36.94-bar",
    "word":"foo-kute-bar"
}
```

Here each token has the `prefix` and `suffix` which are specified using environment variables `TOKEN_PREFIX` and `TOKEN_SUFFIX` correspondingly. If the variables are not initialized, then no suffix or prefix is added to the token.

You can search for tokens generated previously as well by word:

```sh
curl localhost:1717 -d '{"word": "foo-kute-bar"}'
```

which outputs something like this:

```sh
{
    "items": [
        {
            "date":"foo-13-02-2023@20:46:36.94-bar",
            "uuid":"foo-550a3a27-123c-499f-aad1-8091ff41a0ff-bar",
            "word":"foo-kute-bar"
        },
        {
            "word":"foo-kute-bar",
            "uuid":"foo-53bfb3c1-a9bc-4e8e-a3f0-46494c0aaa5e-bar",
            "date":"foo-13-02-2023@20:49:45.96-bar"
        }
    ],
    "found":true
}
```

And by date as well. To view the content of the `registry` use `dump` api method:

```sh
curl localhost:1717/dump
```
