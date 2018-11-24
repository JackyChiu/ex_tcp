# Build
FROM bitwalker/alpine-elixir:1.7 as build
COPY . .

ENV MIX_ENV=prod

RUN rm -Rf _build
RUN mix local.hex --force
RUN mix deps.get
RUN mix release

RUN APP=ex_tcp && \
  RELEASE_DIR=`ls -d _build/prod/rel/$APP/releases/*/` && \
  mkdir /release && \
  tar -xf "$RELEASE_DIR/$APP.tar.gz" -C /release

# Run
FROM bitwalker/alpine-erlang:latest

EXPOSE 4000
ENV PORT=4000
ENV MIX_ENV=prod

COPY --from=build /release .
USER default

ENTRYPOINT ["/opt/app/bin/ex_tcp"]
CMD ["foreground"]
