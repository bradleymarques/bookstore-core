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
try running `sudo chown -R $USER:$USER` and re-run the build command.

Then, spin up the application:

```sh
docker-compose up
```

The application is now running on `localhost:3000`.

An application such as [Postman](https://www.postman.com/) can be used to
manually interact with the API.

Please see the LaTeX documentation in the `documentation/` folder for details
on the API endpoints.
