# Slerk API

## Installation

To setup your Phoenix app, you'll need [Elixir](http://elixir-lang.org/) and [PostgreSQL](http://www.postgresql.org/) installed on your system. The easiest way to install Elixir is with [Homebrew](http://brew.sh/):

```bash
brew update && brew install elixir
```

Once you've installed Elixir, you'll need to install Postgres, along with the `psql` command line tool. The easiest way to install both of these is to use Homebrew again:

```bash
brew install postgres
```

 To start your Phoenix app and run it, just follow these steps:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
