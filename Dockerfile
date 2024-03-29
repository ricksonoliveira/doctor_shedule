FROM elixir:alpine as build

RUN apk add --no-cache build-base npm git python3

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV=prod

COPY mix.* ./
COPY config config
RUN mix do deps.get, deps.compile

COPY assets/package*.json ./assets/
RUN npm install --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets
RUN mix assets.deploy

COPY lib lib
RUN mix do compile, release

# prepare release
FROM alpine as app

RUN apk add --no-cache build-base npm git python3

WORKDIR /app
RUN chown nobody /app

USER nobody

COPY --from=build --chown=nobody:root /app/_build/prod/rel/doctor_schedule ./

ENV home=/app

CMD [ "bin/doctor_schedule", "start" ]
