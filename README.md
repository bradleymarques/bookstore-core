# Bookstore Core

Ruby on Rails application for a proof-of-concept online bookstore API application.

More detailed LaTeX documentation can be found in the `documentation/` folder.

## Running the application

First clone the repository:

```sh
git clone git@github.com:bradleymarques/bookstore-core.git
```

Build the project using `docker-compose`:

```sh
docker-compose build
```

NOTE: If you are running Linux and encounter permission errors using the above,
try running `sudo chown -R $USER:$USER .` and re-run the build command.

We then need to create the database. Do this by running:

```sh
docker-compose run -e "RAILS_ENV=development" web rake db:drop db:create db:migrate
```

This will drop, create, and migrate the "development" database.

To seed the database with sample data, run:

```sh
docker-compose run -e "RAILS_ENV=development" web rake db:seed
```

Then, spin up the application:

```sh
docker-compose up
```

The application is now running on `localhost:3000`.

An application such as [Postman](https://www.postman.com/) can be used to
manually interact with the API.

Please see the LaTeX documentation in the `documentation/` folder for details
on the API endpoints.

## Running Tests

To run the test suite, first create the test database:

```sh
docker-compose run -e "RAILS_ENV=test" web rake db:create db:migrate
```

Then run all tests:

```sh
docker-compose run -e "RAILS_ENV=test" web rails test
```
