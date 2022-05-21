# Scrap preview

This repo contains partial code of my Scrap project.

Some interesting stuff is here: https://github.com/marcinbiegun/scrap_preview/tree/master/lib/scrap

## Scrap

Scrap is a web application written in Elixir and Phoenix framework. It
requires a PostgreSQL database to run.

It purpose is to crawl the supported online stores looking for current
product offers.

The web interface allows for easy browsing of all offers.

## Architecture

* Web crawlers run as GenServers under Scrap.Crawler.Supervisor tree
  * crawlers run on a single process per store to not stress 3rd parties too much,
  * crawlers look for offers and dump them to offer_points table.

* Scrap.OffersAggregator is scanning through new offer_points and
  updating the state of current offerings in other database
  tables.

* Scrap.Web
  * presents current offerings data in a web interface.

## Parallelism docs

* https://hexdocs.pm/elixir/master/GenServer.html
* https://hackernoon.com/background-processing-using-elixir-genserver-and-the-erlang-queue-class-8d476d4942c2
* https://www.culttt.com/2016/07/27/understanding-concurrency-parallelism-elixir/

## Data model

Kind of complete database: https://solecollector.com/

brand -> line -> model -> colorway

