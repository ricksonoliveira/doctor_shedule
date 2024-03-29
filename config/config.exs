# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :doctor_schedule,
  ecto_repos: [DoctorSchedule.Repo]

# Configures the endpoint
config :doctor_schedule, DoctorScheduleWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: DoctorScheduleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DoctorSchedule.PubSub,
  live_view: [signing_salt: "qkqM+Qab"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :doctor_schedule, DoctorSchedule.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :doctor_schedule, DoctorScheduleWeb.Auth.Guardian,
  issuer: "doctor_schedule",
  secret_key: System.get_env("GUARDIAN_SECRET") || "123123"

config :doctor_schedule, DoctorSchedule.Shared.MailProvider.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: System.get_env("SMTP_HOST"),
  hostname: System.get_env("SMTP_HOST"),
  port: System.get_env("SMTP_PORT"),
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  tls: :if_available,
  allowed_tls_versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"],
  ssl: false,
  retries: 1,
  no_mx_lookup: false,
  auth: :cram_md5

config :doctor_schedule, :mongo_db,
  url: System.get_env("MONGO_URL") || "mongodb://localhost:27017/doctor_schedule",
  pool_size: System.get_env("MONGO_POOL_SIZE") || 10

config :doctor_schedule, :redis_config,
  url: System.get_env("REDIS_URL") || "redis://localhost:6379"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
