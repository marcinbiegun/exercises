# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :playground,
  ecto_repos: [Playground.Repo]

# Configures the endpoint
config :playground, PlaygroundWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2Ry+QdXuVg29mHy1hTxBhgk8CAzdn+V/OkSzn8elQnC4u4fk1eWGv7k6ZENY9tDH",
  render_errors: [view: PlaygroundWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Playground.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Playground.Coherence.User,
  repo: Playground.Repo,
  module: Playground,
  web_module: PlaygroundWeb,
  router: PlaygroundWeb.Router,
  messages_backend: PlaygroundWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, PlaygroundWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
