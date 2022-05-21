# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :scrap,
  ecto_repos: [Scrap.Repo]

# Configures the endpoint
config :scrap, ScrapWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "f6n0skiM+qSBRMvmntSm3DR7akxScRO3WgFW6G8SfyKLkLMIAReigH7tgiJgR7Ae",
  render_errors: [view: ScrapWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Scrap.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
