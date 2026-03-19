# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :ats,
  ecto_repos: [Ats.Repo]

# Configures the endpoint
config :ats, AtsWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: AtsWeb.ErrorHTML, json: AtsWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Ats.PubSub

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :ats, Ats.Mailer, adapter: Swoosh.Adapters.Local

config :geocoder, Geocoder.Providers.OpenStreetMaps, key: nil

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
