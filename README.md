# dbt and SQLite

[![Lint dbt models](https://github.com/edgarrmondragon/dbt-sqlite-example/actions/workflows/lint-models.yml/badge.svg?event=push)](https://github.com/edgarrmondragon/dbt-sqlite-example/actions/workflows/lint-models.yml)

Example [dbt] project with SQLite.

## Dependencies

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
        dataset: "{{ env_var('PWD') }}/dbs/dataset.db"
      schema_directory: "{{ env_var('PWD') }}/dbs"
```

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

[poetry]: https://python-poetry.org/
[sqlite3]: https://sqlite.org/download.html
[dbt]: https://getdbt.com
[SQLFluff]: https://docs.sqlfluff.com
