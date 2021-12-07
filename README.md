# dbt and SQLite

[![Lint dbt models](https://github.com/edgarrmondragon/dbt-sqlite-example/actions/workflows/lint-models.yml/badge.svg?event=push)](https://github.com/edgarrmondragon/dbt-sqlite-example/actions/workflows/lint-models.yml)
[![Test data](https://github.com/edgarrmondragon/dbt-sqlite-example/actions/workflows/test.yml/badge.svg)](https://github.com/edgarrmondragon/dbt-sqlite-example/actions/workflows/test.yml)

Example [dbt] project with SQLite.

## Dependencies

- [Kaggle CLI]
- [poetry]
- [sqlite3]

## Execution

### Set up profile

Add the following lines to you `~/.dbt/profiles.yml`:

```yaml
dbt_sqlite:
  target: dev
  outputs:
    dev:
      type: sqlite
      threads: 1
      database: database
      schema: main
      schemas_and_paths:
        main: "{{ env_var('PWD') }}/dbs/etl.db"
      schema_directory: "{{ env_var('PWD') }}/dbs"
```

### [Setup your Kaggle credentials][kaggle-api]

### Run models

```shell
make run
```

### Documentation

```shell
make lineage
```

### Lint with [SQLFluff]

```shell
make lint
```

[Kaggle CLI]: https://github.com/Kaggle/kaggle-api
[poetry]: https://python-poetry.org/
[sqlite3]: https://sqlite.org/download.html
[dbt]: https://getdbt.com
[SQLFluff]: https://docs.sqlfluff.com
[kaggle-api]: https://github.com/Kaggle/kaggle-api#api-credentials
