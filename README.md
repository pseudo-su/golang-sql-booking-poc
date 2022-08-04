# Golang SQL booking POC

This is a test project to create an examle  Booking implementation using Golang.

## Goals

* WIP: Maintain up/down migration files maintanied as `.sql`
  * OPT: [golang-migrate/migrate](https://github.com/golang-migrate/migrate)
  * OPT: [pressly/goose](https://github.com/pressly/goose)
  * OPT: [jackc/tern](https://github.com/jackc/tern)
* WIP: Use a type-safe SQL query builder [investigate these](https://awesome-go.com/sql-query-builders/)
  * OPT: [go-jet/jet](https://github.com/go-jet/jet)
  * OPT: [bokwoon95/go-structured-query](https://github.com/bokwoon95/go-structured-query)
  * OPT: [kyleconroy/sqlc](https://github.com/kyleconroy/sqlc)
  * OPT: [xo/xo](https://github.com/xo/xo)

## Features

* Using UUID as primary keys.
* Automatic timestamps for `created_at` and `updated_at`
* Soft delete on records by using `deleted_at` columns set to either `NULL` or the timestamp of when it was deleted.
* [Cascading soft deletes](https://stackoverflow.com/questions/506432/cascading-soft-delete/53046345#53046345) using postgres "inheritance" feature

## Contributing quickstart

### Global/system dependencies

You will need to have the following global dependencies installed on your local machine

* Go `1.18`
* AWS CLI
* Java (Amazon coretto version `17.0.0.35.1`)
* NodeJS (Installed using `nvm`)

```sh
# On macs install coreutils
brew install coreutils

# On macs go can be installed through homebrew
brew install go@1.18

# AWS CLI
brew install awscli

# If using sdkman to manage Java versions
sdk env install
sdk env use
```

### Commands

```sh
# Install dependencies
make deps.install

# Run code verification
make verify

# Run code verification applying auto-fixes where possible
make verify.fix

# Start the debstack (postgres & pgadmin in devstack/docker-compose.yml)
make devstack.start

# Run migrations
./tools/migrate \
  -database "postgres://root:1234@localhost:5432/golang_sql_booking_poc_dev?sslmode=disable" \
  -source file://./migrations \
  up

# Run migrations
./tools/migrate \
  -database "postgres://root:1234@localhost:5432/golang_sql_booking_poc_dev?sslmode=disable" \
  -source file://./migrations \
  up

# Generate Jet query builder
rm -r ./internal/jet

go run github.com/go-jet/jet/v2/cmd/jet@latest \
  -dsn="postgres://root:1234@localhost:5432/golang_sql_booking_poc_dev?sslmode=disable" \
  -schema=public \
  -path ./internal/jet

cp -r ./internal/jet/golang_sql_booking_poc_dev/public/* ./internal/jet

rm -r ./internal/jet/golang_sql_booking_poc_dev

# Generate go-structured-query query builder
go run github.com/bokwoon95/go-structured-query/cmd/sqgen-postgres@latest \
  tables \
  --database "postgres://root:1234@localhost:5432/golang_sql_booking_poc_dev?sslmode=disable" \
  --schemas public \
  --pkg gsq \
  --directory internal/gsq \
  --file tables.go \
  --overwrite

# Seed DB with data
./cli generate-seed-data
```
