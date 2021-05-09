PROJECT := testing_sqlite
INSTALL_STAMP := .install.stamp
COMPILE_STAMP := .compile.stamp
POETRY := $(shell command -v poetry 2> /dev/null)

install: $(INSTALL_STAMP)
$(INSTALL_STAMP): pyproject.toml poetry.lock
	@if [ -z $(POETRY) ]; then echo "Poetry could not be found. See https://python-poetry.org/docs/"; exit 2; fi
	$(POETRY) install
	touch $(INSTALL_STAMP)

raw_data/scanner_data.csv:
	$(POETRY) run kaggle datasets download --force marian447/retail-store-sales-transactions
	unzip -o retail-store-sales-transactions.zip -d raw_data

dbs/dataset.db: dbs/create_scanner_data.sql raw_data/scanner_data.csv
	rm -f $@
	cat dbs/create_scanner_data.sql | sqlite3 $@
	tail -n +2 raw_data/scanner_data.csv | sqlite3 $@ ".mode csv" ".import /dev/stdin scanner_data"

.PHONY: run
run: dbs/dataset.db
	$(POETRY) run dbt run

compile: target/compiled/$(PROJECT)/$(COMPILE_STAMP)
target/compiled/$(PROJECT)/$(COMPILE_STAMP): dbs/dataset.db
	$(POETRY) run dbt compile
	touch target/compiled/$(PROJECT)/$(COMPILE_STAMP)

docs: target/index.html
target/index.html: dbs/dataset.db
	$(POETRY) run dbt docs generate

.PHONY: lineage
lineage: docs
	$(POETRY) run dbt docs serve

.PHONY: lint
lint:
	$(POETRY) run sqlfluff lint

.PHONY: fix
fix:
	$(POETRY) run sqlfluff fix
