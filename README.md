# Bookstore Core

Ruby on Rails application for a proof-of-concept online bookstore API application.

More detailed LaTeX documentation can be found in the `documentation/` folder.

## Running the application

# Installing and Running Code Submission

Remove existing repository, if applicable:

```sh
sudo rm -rf bookstore-core
```

Clone project:

```sh
git clone git@github.com:bradleymarques/bookstore-core.git
```

Build project:

```sh
cd bookstore-core
docker-compose down
sudo chown -R $USER:$USER . # This step seems to be required on Linux
```

Attempt to run the tests:

```sh
docker-compose run -e "RAILS_ENV=test" web rake db:create db:migrate
```

If that results in a Postgres permission issue follow the steps
[here](https://github.com/sameersbn/docker-postgresql/issues/112), namely:

```sh
docker ps
docker exec -it <hash> bash
psql username=postgres
ALTER ROLE postgres WITH PASSWORD 'password';
\q
exit
docker-compose run -e "RAILS_ENV=test" web rake db:create db:migrate
```

If some tests fail, it is because a `jwt_secret` is not set. Generate credentials:

```sh
rm config/credentials.yml.enc
EDITOR="vim --wait" bin/rails credentials:edit
```

Add the following:

```txt
jwt_secret: <some_string>
```

Save and exit.

Run tests:

```sh
docker-compose run -e "RAILS_ENV=test" web rails test
```

Run server:

```sh
docker-compose run -e "RAILS_ENV=development" web rake db:drop db:create db:migrate db:seed
docker-compose up
```

Visit: `http://localhost:3000/api/v1/books.json`
